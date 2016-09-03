class SubscriptionsController < ApplicationController

  before_filter :verify_logged_in, only: [:create]

  def create
    checkout_type = params[:checkout_type]
    stripe_token = params[:token]

    result = SubscriptionService.instance.activate_subscription(current_user, checkout_type, stripe_token)
    if result[:status] == 'succeeded'

    else

    end
  end

  def stripe_event
    event_json = JSON.parse(request.body.read)
    SubscriptionService.instance.handle_stripe_event(event_json['id'])
    head status: 200
  end
end
