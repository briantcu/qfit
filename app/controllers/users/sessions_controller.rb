require 'digest/sha1'

class Users::SessionsController < Devise::SessionsController

  def create
    email = params[:email]
    password = params[:password]

    #Needed to incorporate old login mechanism. Can be removed once all users have been migrated to new system.
    user = User.try_login(email, password)
    return failure unless user

    if user.valid_password?(password)
      sign_in(:user, user)
      user.ensure_authentication_token
      render :json=> {:success => true, :token => user.authentication_token}
      return
    end
    failure


    super

  end

  def destroy
    user.reset_authentication_token!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render :status => 200, :json => {}

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
end