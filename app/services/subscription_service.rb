require 'singleton'
require 'stripe'

class SubscriptionService
  include Singleton

  #Quadfit checkout types
  PREMIUM_CHECKOUT  = 'PREMIUM_CHECKOUT'
  GOLD_CHECKOUT = 'GOLD_CHECKOUT'
  BRONZE_CHECKOUT = 'BRONZE_CHECKOUT'
  SILVER_CHECKOUT = 'SILVER_CHECKOUT'

  #Stripe plan types
  PREMIUM_MEMBER = 'PremiumMember'
  GOLD_COACH = 'GoldCoach'
  SILVER_COACH = 'SilverCoach'
  BRONZE_COACH = 'BronzeCoach'

  Stripe.api_key = Qfit::Application.config.stripe_secret_key

  def activate_subscription(user, checkout_type, stripe_token)
    response = {status: 'success', message: 'none'}

    stripe_customer_id = retrieve_or_create_stripe_customer_id(user, stripe_token)

    plan = get_plan_from_type(checkout_type)

    if plan.blank? || stripe_customer_id.blank?
      Rollbar.error('Cannot create plan. checkout type: ' + checkout_type + ' and user: ' + user.id.to_s)
      response[:status] = 'failed'
      response[:message] = "Sorry! We can't process your request right now, but we're looking into it."
    else
      begin
        subscription = update_or_create_subscription(stripe_customer_id, plan, user)
      rescue Stripe::CardError => e
        Rails.logger.info('Stripe - error checking out for user ' + user.id.to_s)
        Rails.logger.info(e)
        body = e.json_body
        err  = body[:error]
        response[:status] = 'failed'
        response[:message] = err[:message]
      rescue => e
        Rails.logger.info('Stripe - error checking out for user ' + user.id.to_s)
        Rails.logger.info(e)
        Rollbar.error(e)
        response[:status] = 'failed'
        response[:message] = "Sorry! We can't process your request right now, but we're looking into it."
      else
        user.update!(active_until: Time.zone.at(subscription.current_period_end).to_datetime, subscription_id: subscription.id, paid_tier: 2, status: 1)
        if user.is_coach?
          num_accts = get_num_accts_from_plan(plan)
          user.coach_account.num_accts = num_accts
          user.coach_account.save!
        end
      end
    end
    EmailService.perform_async(:billing_happened)
    response
  end

  def update_billing(user, stripe_token)
    response = {status: 'success', message: 'none'}

    begin
      customer = Stripe::Customer.retrieve(user.stripe_id)
      customer.source = stripe_token
      customer.save
    rescue Stripe::CardError => e
      body = e.json_body
      err  = body[:error]
      response[:status] = 'failed'
      response[:message] = err[:message]
    rescue => e
      Rollbar.warning(e)
      response[:status] = 'failed'
      response[:message] = "Sorry! We can't process your request right now, but we're looking into it."
    end
    response
  end

  def update_subscription(user, new_type)
    response = {status: 'success', message: 'none'}
    # Only for coaches, bc only coaches have multiple sub types
    new_plan = get_plan_from_type(new_type)
    begin
      subscription = Stripe::Subscription.retrieve(user.subscription_id)
      subscription.plan = new_plan
      subscription.save
    rescue => e
      Rollbar.error(e)
      response[:status] = 'failed'
      response[:message] = "Sorry! We can't process your request right now, but we're looking into it."
    else
      # active_until is updated with subscription.updated webhook
      if user.is_coach?
        num_accts = get_num_accts_from_plan(new_plan)
        user.coach_account.num_accts = num_accts
        user.coach_account.save!
      end
    end
    EmailService.perform_async(:billing_happened)
    response
  end

  def delete_subscription(user)
    begin
      subscription = Stripe::Subscription.retrieve(user.subscription_id)
      sub = subscription.delete(at_period_end: true)
    rescue => e
      Rollbar.error(e)
    ensure
      user.status = 4
      user.save!
    end
    EmailService.perform_async(:billing_happened)
  end

  def handle_stripe_event(id)
    begin
      event = Stripe::Event.retrieve(id)
    rescue => e
      Rollbar.warning(e)
      return
    end

    begin
      Rails.logger.info(event)

      stripe_user_id = event.data['object']['customer']
      user = User.find_by(stripe_id: stripe_user_id)

      Rails.logger.info('Processing Stripe event for user id ' + user.id.to_s)

      EmailService.perform_async(:notify_payment_failed, {user_id: user.id}) if event.type == 'invoice.payment_failed'

      begin
        subscription = Stripe::Subscription.retrieve(user.subscription_id)
      rescue Stripe::InvalidRequestError => e
        deactivate_user(user) # Subscription no longer exists
      rescue => e
        Rollbar.error(e)
      end

      SubscriptionEvent.create(
          user_id: user.id,
          subscription_id: user.subscription_id,
          event: event.type,
          stripe_event_id: event.id,
          subscription_status: subscription.try(:status)
      )
      sync_subscription(user, subscription) if subscription.present?

    rescue => e
      Rails.logger.info(e)
      Rollbar.error(e)
    end
  end

  def update_or_create_subscription(stripe_customer_id, plan, user)
    begin
      subscription = Stripe::Subscription.retrieve(user.subscription_id)
      subscription.plan = plan
      subscription.save
    rescue => e
        subscription = Stripe::Subscription.create(
          customer: stripe_customer_id,
          plan: plan
        )
    end
    subscription
  end

  private

  def retrieve_or_create_stripe_customer_id(user, stripe_token)
    return user.stripe_id if user.stripe_id.present?
    begin
      customer = Stripe::Customer.create(
          source: stripe_token,
          email: user.email
      )
      Rails.logger.info('Created Stripe customer for user id ' + user.id.to_s)
      Rails.logger.info(customer)
      user.update!(stripe_id: customer.id)
      customer.id
    rescue => e
      Rollbar.error(e)
    end
  end

  def sync_subscription(user, subscription)
    if subscription.status == 'active'

      # ACTIVE SUBSCRIPTION
      if user.is_coach?
        plan = subscription.plan['id']
        num_accts = get_num_accts_from_plan(plan)
        user.coach_account.num_accts = num_accts
        user.coach_account.save!

        user.status = 1 # active
        user.active_until = Time.zone.at(subscription.current_period_end).to_datetime
        user.save!
      else
        user.paid_tier = 2
        user.status = 1 # active
        user.active_until = Time.zone.at(subscription.current_period_end).to_datetime
        user.save!
      end
    else

      # NOT ACTIVE
      if subscription.status == 'canceled' || subscription.status == 'unpaid'
        deactivate_user(user)
      else
        user.status = 3 # billing failed
        user.save!
      end
    end

  end

  def deactivate_user(user)
    if user.is_coach?
      user.coach_account.num_accts = 5
      user.coach_account.save!
      user.status = 1
    else
      user.paid_tier = 1
      user.status = 1
    end
    user.save!
  end

  def get_plan_from_type(type)
    if type == PREMIUM_CHECKOUT
      PREMIUM_MEMBER
    elsif type == GOLD_CHECKOUT
      GOLD_COACH
    elsif type == BRONZE_CHECKOUT
      BRONZE_COACH
    elsif type == SILVER_CHECKOUT
      SILVER_COACH
    end
  end

  def get_num_accts_from_plan(plan)
    if plan == GOLD_COACH
      1000000
    elsif plan == SILVER_COACH
      100
    elsif plan == BRONZE_COACH
      30
    end
  end

end