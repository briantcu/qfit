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

    begin
      subscription = Stripe::Subscription.create(
          customer: stripe_customer_id,
          plan: PREMIUM_MEMBER
      )
    rescue Stripe::CardError => e
      body = e.json_body
      err  = body[:error]
      response[:status] = 'failed'
      response[:message] = err[:message]
    rescue => e
      Rollbar.error(e)
      response[:status] = 'failed'
      response[:message] = "Sorry! We can't process your request right now, but we're looking into it."
    else
      current_user.update!(active_until: subscription.current_period_end, subscription_id: subscription.id)
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

  def update_subscription(user, new_plan)
    #@TODO don't give them the option to downgrade if they have more active users than the downgraded level

    begin
      subscription = Stripe::Subscription.retrieve(user.subscription_id)
      subscription.plan = new_plan
      subscription.save
    rescue => e
      Rollbar.error(e)
    else
      #@TODO upgrade or downgrade coach active users.

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

    if event.type == 'customer.subscription.deleted'
      deactivate_user(user)
    elsif %w(customer.subscription.updated invoice.payment_succeeded).include? event.type
      reactivate_user
    elsif event.type == 'invoice.payment_failed'
      deactivate_user(user)
      #@TODO send email
    else
      Rollbar.warning(event.type)
    end
  end

  private

  def retrieve_or_create_stripe_customer_id(user, stripe_token)
    return user.stripe_id if user.stripe_id.present?
    customer = Stripe::Customer.create(
        source: stripe_token,
        email: user.email
    )
    user.update!(stripe_id: customer.id)
    customer.id
  end

  def deactivate_user(user)
    #if for an individual, downgrade paid_tier. leave status as active, keep creating workouts
    #if for a coach, make inactive, stop creating workouts for players
    #@TODO prob put a message on queue so you can respond to webhook
    subscription = Stripe::Subscription.retrieve(user.subscription_id)
    if subscription.status != 'active'
      if (user.level == 5)
        #coach
        user.status = 2
      else
        user.paid_tier = 1
      end
    end
  end

  def reactivate_user
    # if for an individual, make sure paid_tier is in line with what they're paying for. change active_until
    # if for coach, make sure active is set properly and create job to create workouts. update active_until
    #@TODO prob put a message on queue so you can respond to webhook
    subscription = Stripe::Subscription.retrieve(user.subscription_id)
    if subscription.status == 'active'
      if (user.level == 5)
        #coach
        user.status = 2
      else
        user.paid_tier = 1
      end
    end
  end

end