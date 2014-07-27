class Users::PasswordsController < Devise::PasswordsController
  before_action :set_user, only: [:update]
  before_filter :verify_is_logged_in, only: [:update]

  def update
    if @user.update_with_password(change_password_params)
      sign_in @user, :bypass => true
      #Can be removed when every user is on new system
      @user.update_og_password(@user.encrypted_password)
      render :status => 201, :json => {}
    else
      render :status => 404, :json => {}
    end

  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def verify_is_logged_in
    unauthorized unless !current_user.nil? && (current_user.id == @user.id)
  end

  def change_password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

end