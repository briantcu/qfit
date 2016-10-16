require 'singleton'
require 'stripe'

class SubscriptionService
  include Singleton

  #Quadfit checkout types
  PREMIUM_CHECKOUT  = 'PREMIUM_CHECKOUT'

  #Stripe plan types
  PREMIUM_MEMBER = 'PremiumMember'

  #@TODO set API key in env var
  Stripe.api_key = "sk_test_UMmjXKClIIsWlkkIC2MwFe1b"

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
        subscription = Stripe::Subscription.create(
            customer: stripe_customer_id,
            plan: plan
        )
      rescue Stripe::CardError => e
        Qfit::Application.config.logger.info('error checking out for user ' + user.id.to_s)
        Qfit::Application.config.logger.info(e)
        body = e.json_body
        err  = body[:error]
        response[:status] = 'failed'
        response[:message] = err[:message]
      rescue => e
        Qfit::Application.config.logger.info('sending to rollbar - error checking out for user ' + user.id.to_s)
        Qfit::Application.config.logger.info(e)
        Rollbar.error(e)
        response[:status] = 'failed'
        response[:message] = "Sorry! We can't process your request right now, but we're looking into it."
      else
        user.update!(active_until: subscription.current_period_end, subscription_id: subscription.id)
      end
    end
    response
  end

  def update_billing(user, stripe_token)
    response = {status: 'success', message: 'none'}

    customer = Stripe::Customer.retrieve(user.stripe_id)
    customer.source = stripe_token

    begin
      customer.save
      #@TODO maybe reactivate customer, see if you can charge them right now, or if you even need to
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
    # Only for coaches, bc only coaches have multiple sub types
    new_plan = get_plan_from_type(new_type)
    begin
      subscription = Stripe::Subscription.retrieve(user.subscription_id)
      subscription.plan = new_plan
      subscription.save
    rescue => e
      Rollbar.error(e)
    else
      # active_until is updated with subscription.updated webhook
      if user.is_coach?
        num_accts = get_num_accts_from_plan(new_plan)
        user.coach_account.num_accts = num_accts
        user.coach_account.save!
      end
    end
  end

  def delete_subscription(user)
    begin
      subscription = Stripe::Subscription.retrieve(user.subscription_id)
      subscription.delete
    rescue => e
      Rollbar.error(e)
    else
      deactivate_user(user)
    end
  end

  def handle_stripe_event(id)
    begin
      event = Stripe::Event.retrieve(id)
    rescue => e
      Rollbar.warning(e)
      return
    end

    begin
      Qfit::Application.config.logger.info(event)

      stripe_user_id = event.data['object']['customer']
      user = User.find_by(stripe_id: stripe_user_id)

      Qfit::Application.config.logger.info('Processing event for user id ' + user.id.to_s)

      EmailService.perform_async(:notify_payment_failed, {user_id: user.id}) if event.type == 'invoice.payment_failed'

      sync_subscription(user)

    rescue => e
      Qfit::Application.config.logger.info(e)
      Rollbar.error(e)
    end
  end

  private

  def retrieve_or_create_stripe_customer_id(user, stripe_token)
    return user.stripe_id if user.stripe_id.present?
    begin
      customer = Stripe::Customer.create(
          source: stripe_token,
          email: user.email
      )
      user.update!(stripe_id: customer.id)
      customer.id
    rescue => e
      Rollbar.error(e)
    end
  end

  def sync_subscription(user)
    subscription = Stripe::Subscription.retrieve(user.subscription_id)
    if subscription.status == 'active'

      # ACTIVE SUBSCRIPTION
      if user.is_coach?
        plan = subscription.plan['id']
        num_accts = get_num_accts_from_plan(plan)
        user.coach_account.num_accts = num_accts
        user.coach_account.save!

        user.status = 1 # active
        user.active_until = subscription.current_period_end
      else
        user.paid_tier = 2
        user.active_until = subscription.current_period_end
      end
    else

      # NOT ACTIVE
      if user.is_coach?
        if subscription.status == 'canceled' || subscription.status == 'unpaid'
          status = 2 # sub is done
        else
          status = 3 # billing failed
        end
        user.status = status
      else
        if subscription.status == 'canceled' || subscription.status == 'unpaid'
          # deactivated subscription
          user.paid_tier = 1  # downgrade paid tier, which means you'll still create workouts, just won't get extras
          user.status = 1
        else
          user.status = 3 # which means you'll keep recognizing them as having a sub, but you won't give them extras
        end
      end
    end
    user.save!
  end

  def get_plan_from_type(type)
    if type == PREMIUM_CHECKOUT
      PREMIUM_MEMBER
    end
  end

  def get_num_accts_from_plan(plan)
    # @TODO
    20
  end

end