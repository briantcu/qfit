class SubscriptionsController < ApplicationController

  before_filter :verify_logged_in, except: [:stripe_event]

  # /checkout
  def create
    checkout_type = params[:checkout_type]
    stripe_token = params[:token]

    result = SubscriptionService.instance.activate_subscription(current_user, checkout_type, stripe_token)
    if result[:status] == 'succeeded'
      render status: 201, json: {}
    else
      render status: 422, json: {errors: result[:message]}
    end
  end

  def update
    new_type = params[:type]
    SubscriptionService.instance.update_subscription(current_user, new_type)
    if result[:status] == 'succeeded'
      render status: 201, json: {}
    else
      render status: 422, json: {errors: result[:message]}
    end
  end

  # /billing
  def update_billing
    # If you have a failed payment, this won't fix your sub until we get the webhook from stripe
    stripe_token = params[:token]

    result = SubscriptionService.instance.update_billing(current_user, stripe_token)
    if result[:status] == 'succeeded'
      render status: 201, json: {}
    else
      render status: 422, json: {errors: result[:message]}
    end
  end

  def delete
    active_until = SubscriptionService.instance.delete_subscription(current_user)
    render status: 201, json: {message: 'Your subscription will not renew, but you can continue to enjoy your subscription until the billing period ends.'}
  end

  def stripe_event
    event_json = JSON.parse(request.body.read)
    Qfit::Application.config.logger.info(event_json)
    SubscriptionService.instance.handle_stripe_event(event_json['id'])
    head status: 200
  end
end
