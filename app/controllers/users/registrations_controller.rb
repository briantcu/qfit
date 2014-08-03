class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create]

  def create
    #Check validity of sign up code.
    sign_up_code = nil
    if !params[:user][:sign_up_code].empty?
      sign_up_code = SignUpCode.with_code(params[:user][:sign_up_code]).first
      if sign_up_code.nil?
        #That is an invalid sign up code @TODO implement custom return code
        render :status => 422, :json => { :errors => 'Invalid sign up code'}
        return
      else
        #If it's a sub user with code, make sure coach isn't maxed out @TODO implement custom return code
        if sign_up_code.user.coach_account.is_maxed_out
          render :status => 422, :json => { :errors => 'Coach is maxed out'}
          return
        end
      end
    end

    user = User.new(sign_up_params)
    if user.save
      if is_coach_signed_in
        user = RegistrationService.register_user_for_coach(user, current_user)
        #@TODO return sub user object, or at least ID
      else
        user = RegistrationService.register_user(user, sign_up_code, params[:user][:account_type])
        #@TODO prob return user object, or at least ID
        render :json => {:token=>user.authentication_token, :email=>user.email, :account_type=>user.level.to_s, :status=>201}
      end
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  #Returns form
  def new
    super
  end

  private

  def is_coach_signed_in
    !current_user.nil? && current_user.is_coach
  end

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :first_name, :last_name)
  end


end