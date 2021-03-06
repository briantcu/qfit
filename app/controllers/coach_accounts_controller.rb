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
  before_filter :verify_owns_account, except: [:view_team, :view_user, :delete_code]
  before_filter :verify_owns_user, only: [:delete_user, :view_user]
  before_filter :verify_owns_team, only: [:view_team]

  def show
  end

  def delete_user
    user = User.find(params[:user_id])
    if user.group.present?
      GroupJoin.find_by(user_id: user.id).destroy!
    end
    EmailService.perform_async(:coach_deleted_you, {email: user.email})
    user.update_attributes!(level: 2, paid_tier: 1, master_user_id: nil)
    render :show
  end

  def send_invite
    unless @coach_account.can_send_codes?
      render(status: 401, json: {errors: 'You have exceeded your account limit! You can upgrade your account, or delete some sign up codes or athlete accounts.'}) and return
    end

    send_to = params[:send_to]
    sign_up_type = params[:sign_up_type]
    template_id = params[:template_id]
    program_type_id = params[:program_type_id]
    session_service = SessionService.new(session)
    session_service.set_setup_context(nil)
    session_service.set_onboarding(false)
    unless send_to.present? && sign_up_type.present? && template_id.present?
      render(status: 401, json: {}) and return
    end

    template = Group.find(template_id)
    if program_type_id.blank?
      program_type_id = template.program_type
    end
    render json: CoachInviteService.instance.send_invite(send_to, @coach_account, sign_up_type, template_id, program_type_id)
  end

  def delete_code
    code = SignUpCode.find(params[:id])
    unless current_user.present? && code.user_id == current_user.id
      render(status: 401, json: {}) and return
    end
    code.destroy!
    @coach_account = CoachAccount.find_by(user_id: current_user.id)
    render :show
  end

  def view_team
    session_service = SessionService.new(session)
    session_service.set_team_id(params[:group_id])
    session_service.set_viewing('team')
    session_service.set_setup_context('coach_team')
    session_service.set_onboarding(false)
    render status: 200, json: {}
  end

  def view_user
    session_service = SessionService.new(session)
    session_service.set_current_user_id(params[:user_id])
    session_service.set_viewing('user')
    session_service.set_setup_context('coach_sub')
    session_service.set_onboarding(false)
    render status: 200, json: {}
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

  def verify_owns_team
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.owns_group?(params[:group_id]))
  end

  def verify_owns_user
    return unauthorized if current_user.nil?
    unauthorized unless (current_user.is_coach_of_user?(params[:user_id]))
  end
end
