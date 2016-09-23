class Users::RegistrationsController < Devise::RegistrationsController

  include Devise::Controllers::Rememberable
  skip_before_filter :require_no_authentication

  def create
    SessionService.instance.session = session # Used in RegistrationService

    sign_up_code_record = nil
    sign_up_code = try_sign_up_code
    if sign_up_code.present?
      sign_up_code_record = SignUpCode.where(code: sign_up_code, used: false).first
      if sign_up_code_record.nil?
        render status: 470, json: { :errors => 'Invalid sign up code'} and return
      else
        if sign_up_code_record.user.coach_account.is_maxed_out?
          EmailService.perform_async(:coach_maxed, {user_id: sign_up_code_record.user.id})
          render status: 471, json: { :errors => 'Coach is maxed out'} and return
        end
      end
    end

    create_user

    begin
      RegistrationService.instance.register_user(@user, sign_up_code_record, params[:user][:account_type])
      check_tokens
      sign_in @user
      render json: @user.to_json, status: 201 and return
    rescue Exception => e
      Rollbar.error(e)
      warden.custom_failure!
      render json: @user.errors.full_messages, status: 422
    end
  end

  private

  def check_tokens
    if params[:invite_token].present?
      QuadPodService.instance.accept_invite_new_user(params[:invite_token], @user)
    end
  end

  def try_sign_up_code
    sign_up_code = params[:user][:sign_up_code]
    if sign_up_code.blank?
      sign_up_code = session[:sign_up_code]
    end
    sign_up_code
  end

  def create_user
    # If they're coming in from more-info, because they signed up via FB
    if params[:more]
      user_params = session[:onboarding_user].merge(sign_up_params)
      user_params['password'] = Devise.friendly_token[0,20]
    else
      user_params = sign_up_params
    end
    @user = User.new(user_params)
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :sex, :user_name)
  end
end