class SignInUpController < ApplicationController
  before_action :save_sign_up_code_in_session, only: [:sign_up]
  before_action :verify_not_logged_in, only: [:login, :sign_up, :sign_up_coach]

  def sign_up
    gon.push(
        {
            sign_up_code: session[:sign_up_code]
        }
    )
    session_service = SessionService.new(session)
    session_service.set_invite_token(params[:pod_t])
    render layout: 'full_page'
  end

  def sign_up_coach
    session_service = SessionService.new(session)
    session_service.set_invite_token(params[:pod_t])
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

  def verify_not_logged_in
    if current_user.present?
      redirect_to(determine_redirect(current_user)) and return
    end
  end
end