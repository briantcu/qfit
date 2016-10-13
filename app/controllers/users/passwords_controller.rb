class Users::PasswordsController < Devise::PasswordsController

  skip_before_filter :require_no_authentication

  def update
    user = User.reset_password_by_token(
        reset_password_token: params[:user][:reset_password_token],
        password: params[:user][:password],
        password_confirmation: params[:user][:password_confirmation]
    )
    if user.errors.empty?
      sign_in user, bypass: true
      render status: 201, json: {location: determine_redirect(user)}
    else
      render status: 422, json: {errors: user.errors.full_messages}
    end
  end

  def forgot
    user = User.where(email: params[:email]).first
    if user.present?
      user.send_reset_password_instructions
      if successfully_sent?(user)
        render status: 200, json: {}
      else
        render status: 422, json: { :errors => 'A problem was encountered sending the password reset email.'}
      end
    else
      render status: 404, json: { :errors => 'There is no account with that email!'}
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def change_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def verify_logged_in
    unauthorized unless current_user.present?
  end
end