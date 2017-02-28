require 'digest/sha1'

class Users::SessionsController < Devise::SessionsController

  skip_before_filter :require_no_authentication, only: :create

  def create
    process_api_sign_in(params[:email], params[:password])
  end

  def destroy
    current_user.reset_authentication_token
    sign_out
    session_service = SessionService.new(session)
    session_service.clear
    render status: 200, json: {}
  end

  after_filter :set_csrf_header, only: [:create]

  protected

  #@TODO needed?
  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def failure
    render json: { success: false, errors: 'Invalid Login' }, status: :unauthorized
  end

  def process_api_sign_in(email, password)
    user = User.where('lower(email) = ?', email.downcase).first
    return failure unless user.present?

    if user.needs_pw_reset
      user.send_reset_password_instructions
      render status: 401, json: {success: false, errors: 'Looks like you need a password reset! We just emailed you instructions.'} and return
    end

    if user.valid_password?(password)
      sign_in(:user, user)
      user.ensure_authentication_token
      # Make sure some routines get created if the user hasn't logged in in a while
      if RoutineService.get_open_workouts_start_today(user).count == 0 && !user.is_coach?
        RoutineService.new(user, 'CRON', Time.zone.today).create_routines
      end
      check_tokens(user) # This is for if a user invites someone to the quad pod, but they're an existing user...could happen with an invite via text message
      session_service = SessionService.new(session)
      session_service.set_current_user_id(user.id)
      session_service.set_viewing('user') unless user.is_coach?
      location = stored_location_for(user) || determine_redirect(user)
      Analytics.identify(
          user_id: "#{user.id}",
          traits: { email: "#{ user.email }", level: user.level, first_name: "#{user.first_name}", last_name: "#{user.last_name}" },
      )
      Analytics.track(
          user_id: "#{user.id}",
          event: 'Logged In',
          properties: { facebook: false }
      )
      render json: {success: true, token: user.authentication_token, user_id: user.id, user_name: user.user_name, location: location} and return
    end
    failure
  end

  def determine_redirect(user)
    if user.is_coach?
      '/coach'
    elsif (user.program_type.blank?) || (user.user_schedule.blank?) ||  user.user_schedule.invalid? || user.hor_push_max.blank?
      '/setup/goal'
    else
      '/workout'
    end
  end

  def check_tokens(user)
    if session[:invite_token].present?
      QuadPodService.instance.accept_invite_new_user(session[:invite_token], user)
    end
  end
end