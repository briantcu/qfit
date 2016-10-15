class SignInUpController < ApplicationController
  before_action :save_sign_up_code_in_session, only: [:sign_up]

  def sign_up
    gon.push(
        {
            sign_up_code: session[:sign_up_code]
        }
    )
    render layout: 'full_page'
  end

  def sign_up_coach
    render layout: 'full_page'
  end

  def login
    render layout: 'full_page'
  end

  def forgot
    render layout: 'full_page'
  end

  def more_info
    onboarding_user_light = {}
    onboarding_user_light[:first_name] = session[:onboarding_user]['first_name']
    onboarding_user_light[:last_name] = session[:onboarding_user]['last_name']
    onboarding_user_light[:email] = session[:onboarding_user]['email']
    gon.push(
        {
            onboarding_user: onboarding_user_light,
            sign_up_code: session[:sign_up_code]
        }
    )
    render layout: 'full_page'
  end

  private

  def save_sign_up_code_in_session
    if params[:qfcode]
      session_service = SessionService.new(session)
      session_service.set_sign_up_code(params[:qfcode])
    end
  end
end