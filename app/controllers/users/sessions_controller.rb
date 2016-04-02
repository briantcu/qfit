require 'digest/sha1'

class Users::SessionsController < Devise::SessionsController

  def create
    process_api_sign_in(params[:email], params[:password])
  end

  def destroy
    current_user.reset_authentication_token
    sign_out
    render status: 200, json: {}
  end

  after_filter :set_csrf_header, only: [:create]

  protected

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def failure
    render json: { success: false, errors: 'Invalid Login' }, status: :unauthorized
  end

  def process_api_sign_in(email, password)
    user = User.find_by_email(email)
    return failure unless user.present?

    if user.valid_password?(password)
      sign_in(:user, user)
      user.ensure_authentication_token
      # Make sure some routines get created if the user hasn't logged in in a while
      if RoutineService.get_open_workouts_start_today(user).count == 0
        RoutineService.new(user, 'CRON', Date.today, false).create_routines
      end
      render json: {success: true, token: user.authentication_token, user_id: user.id, user_name: user.displayed_user_name} and return
    end
    failure
  end
end