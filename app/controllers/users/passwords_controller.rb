class Users::PasswordsController < Devise::PasswordsController
  before_action :set_user, only: [:update, :reset]
  before_filter :verify_is_logged_in, only: [:update]
  prepend_before_filter :require_no_authentication, :only => [ :reset, :edit]

  def update
    if @user.update_with_password(change_password_params)
      sign_in @user, :bypass => true
      #Can be removed when every user is on new system
      render :status => 201, :json => {}
    else
      render :status => 404, :json => {}
    end

  end

  def reset
    @user.send_reset_password_instructions
    if successfully_sent?(@user)
      head :status => 200
    else
      render :status => 422, :json => { :errors => @user.errors.full_messages }
    end
  end

  respond_to :json
  def edit
    user = User.reset_password_by_token(params)
    if user.errors.empty? && user.email == params[:email]
      sign_in user, :bypass => true
      render :json=> {:success => true, :token => user.authentication_token}
      return
    end
    render :status => 422, :json => { :errors => user.errors.full_messages }
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