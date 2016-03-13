class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication

  @user

  def create
    #Check validity of sign up code.
    sign_up_code = nil
    if params[:user][:sign_up_code].present?
      sign_up_code = SignUpCode.with_code(params[:user][:sign_up_code]).first
      if sign_up_code.nil?
        render :status => 470, :json => { :errors => 'Invalid sign up code'}
        return
      else
        if sign_up_code.user.coach_account.is_maxed_out
          render :status => 471, :json => { :errors => 'Coach is maxed out'}
          return
        end
      end
    end

    @user = User.new(sign_up_params)

    # Has to be done before user.save below because it assigns a password
    if is_coach_signed_in
      temp_password = assign_temp_password
    end

    if @user.save
      if is_coach_signed_in
        @user = RegistrationService.register_user_for_coach(@user, current_user, temp_password)
      else
        @user = RegistrationService.register_user(@user, sign_up_code, params[:user][:account_type])
      end
      check_tokens
      render :json => @user.to_json, :status=>201
    else
      warden.custom_failure!
      render :json => @user.errors, :status=>422
    end
  end

  #Returns form
  def new
    super
  end

  private

  def check_tokens
    if params[:invite_token].present?
      QuadPodService.new.accept_invite_new_user(params[:invite_token], @user)
    end
  end

  def is_coach_signed_in
    !current_user.nil? && current_user.is_coach
  end

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :first_name, :last_name)
  end

  def assign_temp_password
    temp_password = RegistrationService.generate_password
    @user.password = temp_password
    temp_password
  end

end