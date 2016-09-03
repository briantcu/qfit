# == Schema Information
#
# Table name: coach_accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  num_accts     :integer
#  billing_email :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  active        :boolean          default(TRUE)
#  active_until  :datetime
#

class CoachAccountsController < ApplicationController
  before_filter :verify_owns_account
  before_filter :verify_owns_user, only: [:delete_user]

  def show
  end

  def add_user
    if @coach_account.is_maxed_out?
      render status: 471, json: { errors: 'Coach is maxed out'}
    else
      @user = User.new(sign_up_params)
      @user = RegistrationService.instance.register_user_for_coach(@user, current_user)
      session[:current_user_id] = @user.id
    end
  end

  def delete_user
    user = User.find(params[:user_id])
    EmailService.perform_async(:coach_deleted_you, {email: user.email})
    user.destroy!
    render status: 201, json: {}
  end

  def send_invite
    send_to = params[:send_to]
    render json: CoachInviteService.instance.send_invite(send_to, @coach_account)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_coach_account
    @coach_account = CoachAccount.find(params[:id])
  end

  def verify_owns_account
    return unauthorized if current_user.nil?
    set_coach_account
    unauthorized unless @coach_account.user_id == current_user.id
  end

  def verify_owns_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.is_coach_of_user?(params[:user_id]))
  end

  def sign_up_params
    params.require(:user).permit(:email, :first_name, :last_name, :sex)
  end

end
