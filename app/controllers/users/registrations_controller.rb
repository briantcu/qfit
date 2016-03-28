class Users::RegistrationsController < Devise::RegistrationsController

  skip_before_filter :require_no_authentication

  def create
    #Check validity of sign up code.
    sign_up_code = nil
    if params[:user][:sign_up_code].present?
      sign_up_code = SignUpCode.where(code: params[:user][:sign_up_code]).first
      if sign_up_code.nil?
        render :status => 470, :json => { :errors => 'Invalid sign up code'}
        return
      else
        if sign_up_code.user.coach_account.is_maxed_out?
          EmailService.perform_async(:coach_maxed, {user_id: sign_up_code.user.id})
          render :status => 471, :json => { :errors => 'Coach is maxed out'}
          return
        end
      end
    end

    @user = User.new(sign_up_params)

    begin
      RegistrationService.register_user(@user, sign_up_code, params[:user][:account_type])
      check_tokens
      render json: @user.to_json, status: 201
    rescue
      warden.custom_failure!
      render json: @user.errors, status: 422
    end
  end

  private

  def check_tokens
    if params[:invite_token].present?
      QuadPodService.new.accept_invite_new_user(params[:invite_token], @user)
    end
  end

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :first_name, :last_name, :sex)
  end
end