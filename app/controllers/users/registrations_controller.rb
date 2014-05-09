class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create]

  def create

    user = User.new(sign_up_params)
    if request.path_parameters[:format] == 'json'

      if user.save
        render :json => {:auth_token=>user.authentication_token, :email=>user.email}, :status=>201
        return
      else
        warden.custom_failure!
        render :json => user.errors, :status=>422
      end

    else
      super

    end
  end

  #Returns form
  def new
    super
  end

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :first_name, :last_name)
  end


end