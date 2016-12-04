class SignInUpController < ApplicationController
  before_action :save_codes_in_session, only: [:sign_up]
  before_action :verify_not_logged_in, only: [:login]

  def sign_up
    if current_user
      sign_out current_user
    end

    gon.push(
        {
            sign_up_code: session[:sign_up_code]
        }
    )
    render layout: 'full_page'
  end

  def sign_up_coach
    if current_user
      sign_out current_user
    end
    render layout: 'full_page'
  end

  def login
    render layout: 'full_page'
  end

  def forgot
    render layout: 'full_page'
  end

  def more_info
    Qfit::Application.logger.info(session[:onboarding_user])
    onboarding_user_light = {}
    onboarding_user_light[:first_name] = session[:onboarding_user]['first_name']
    onboarding_user_light[:last_name] = session[:onboarding_user]['last_name']
    onboarding_user_light[:email] = session[:onboarding_user]['email']
    onboarding_user_light[:administrator] = session[:onboarding_user]['administrator']
    gon.push(
        {
            onboarding_user: onboarding_user_light,
            sign_up_code: session[:sign_up_code]
        }
    )
    render layout: 'full_page'
  end

  private

  def save_codes_in_session
    session_service = SessionService.new(session)
    if params[:qfcode]
      session_service.set_sign_up_code(params[:qfcode]) # coach invite for sub user
    end
    if params[:pod_t]
      session_service.set_invite_token(params[:pod_t]) # Invitation to quad pod
    end
  end

  def verify_not_logged_in
    if current_user.present?
      redirect_to(determine_redirect(current_user)) and return
    end
  end
end