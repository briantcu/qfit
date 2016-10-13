class Users::PasswordsController < Devise::PasswordsController

  before_filter :verify_logged_in, only: [:update]

  def update
    if current_user.update_with_password(change_password_params)
      sign_in current_user, bypass: true
      render status: 201, json: {}
    else
      render status: 404, json: {}
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
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

  def verify_logged_in
    unauthorized unless current_user.present?
  end
end