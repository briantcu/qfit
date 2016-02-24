require 'digest/sha1'

class Users::SessionsController < Devise::SessionsController

  def create
    email = params[:email]
    password = params[:password]

    #Needed to incorporate old login mechanism. Can be removed once all users have been migrated to new system.
    user = User.try_login(email, password)

    if request.path_parameters[:format] == 'json'
      process_api_sign_in(user, password)
    else
      super
    end

  end

  def destroy
    current_user.reset_authentication_token
    if request.path_parameters[:format] == 'json'
      sign_out
      render :status => 200, :json => {}
    end
    super
  end

  #Returns form
  def new
    super
  end

  after_filter :set_csrf_header, only: [:new, :create]

  protected

  def set_csrf_header
    response.headers['X-CSRF-Token'] = form_authenticity_token
  end

  def failure
    render json: { success: false, errors: 'Invalid Login' }, :status => :unauthorized
  end


  def process_api_sign_in(user, password)

    return failure unless user

    if user.valid_password?(password)
      sign_in(:user, user)
      user.ensure_authentication_token
      render :json=> {success: true, token: user.authentication_token, user_id: user.id}
      return
    end
    failure
  end
end