class CoachAccountsController < ApplicationController
  before_filter :verify_owns_account, only: [:show, :send_invite, :delete_user, :add_user]
  before_filter :verify_owns_user, only: [:delete_user]

  # GET /coach_accounts/1
  # GET /coach_accounts/1.json
  def show
  end

  def add_user
    if @coach_account.is_maxed_out?
      render :status => 471, :json => { :errors => 'Coach is maxed out'}
    else
      @user = User.new(sign_up_params)
      temp_password = assign_temp_password
      @user = RegistrationService.register_user_for_coach(@user, current_user, temp_password)
      render :json => @user.to_json, :status=>201
    end
  end

  def delete_user
    user = User.find(params[:user_id])
    EmailService.peform_async(:coach_deleted_you, {email: user.email})
    user.destroy!
  end

  def send_invite
    send_to = params[:send_to]
    CoachInviteService.new.send_invite(send_to, @coach_account)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_coach_account
    @coach_account = CoachAccount.find(params[:id])
  end

  def verify_owns_account
    set_coach_account
    (current_user.nil?) ? unauthorized : unauthorized unless
      @coach_account.user_id == current_user.id
  end

  def verify_owns_user
    (current_user.nil?) ? unauthorized : unauthorized unless
      (current_user.is_coach_of_user?(params[:user_id]))
  end

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :first_name, :last_name, :sex)
  end

  def assign_temp_password
    temp_password = RegistrationService.generate_password
    @user.password = temp_password
    temp_password
  end
end
