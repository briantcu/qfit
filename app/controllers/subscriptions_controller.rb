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

  def delete

  end

  def stripe_event
    event_json = JSON.parse(request.body.read)
    Qfit::Application.config.logger.info(event_json)
    SubscriptionService.instance.handle_stripe_event(event_json['id'])
    head status: 200
  end
end
