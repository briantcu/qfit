class Users::RegistrationsController < Devise::RegistrationsController

  include Devise::Controllers::Rememberable
  skip_before_filter :require_no_authentication

  def create
    user = User.where(email: params[:user][:email]).first
    if user.present?
      render status: 422, json: { :errors => ['That email has already been taken']} and return
    end

    sign_up_code_record = nil
    sign_up_code = try_sign_up_code
    if sign_up_code.present?
      sign_up_code_record = SignUpCode.where(code: sign_up_code, used: false).first
      if sign_up_code_record.nil?
        render status: 470, json: { :errors => ['That sign up code is invalid']} and return
      else
        if sign_up_code_record.user.coach_account.is_maxed_out?
          EmailService.perform_async(:coach_maxed, {user_id: sign_up_code_record.user.id})
          render status: 471, json: { :errors => ['Uh oh! Your coach has already used all of their accounts.']} and return
        end
      end
    end

    create_user

    begin
      session_service = SessionService.new(session)
      RegistrationService.instance.register_user(@user, sign_up_code_record, params[:user][:account_type], session_service)
      check_tokens
      sign_in @user
      session_service.set_sign_up_code(nil)
      render json: @user.to_json, status: 201 and return
    rescue Exception => e
      Rollbar.error(e)
      warden.custom_failure!
      render json: {errors: @user.errors.full_messages.uniq}, status: 422
    end
  end

  private

  def check_tokens
    if session[:invite_token].present?
      QuadPodService.instance.accept_invite_new_user(session[:invite_token], @user)
    end
  end

  def try_sign_up_code
    # Coach sign up code
    sign_up_code = params[:user][:sign_up_code]
    if sign_up_code.blank?
      sign_up_code = session[:sign_up_code]
    end
    sign_up_code
  end

  def create_user
    # If they're coming in from more-info, because they signed up via FB
    if params[:more]
      Rails.logger.info('About to register Facebook user coming from more-info')
      user_params = session[:onboarding_user].merge(sign_up_params)
      Rails.logger.info(user_params)
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