class CoachAccountsController < ApplicationController
  before_filter :verify_owns_account, only: [:show, :update, :send_invite, :delete_user]
  before_filter :verify_owns_user, only: [:delete_user]

  # GET /coach_accounts/1
  # GET /coach_accounts/1.json
  def show
  end

  def delete_user
    user = User.find(params[:user_id])
    #@TODO check allowed accounts vs max and account status
    EmailService.peform_async(:coach_deleted_you, {email: user.email})
    user.destroy!
  end

  def send_invite
    #@TODO Check max accounts
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
      (current_user.is_coach_of_user(params[:user_id].to_i))
  end
end
