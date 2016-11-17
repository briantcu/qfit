# == Schema Information
#
# Table name: pod_invites
#
#  id         :integer          not null, primary key
#  inviter_id :integer
#  sent_to    :string(255)
#  status     :integer
#  invitee_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class PodInvitesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_pod_invite, only: [:show, :accept, :deny]
  before_filter :verify_invitee, only: [:accept, :deny]

  # GET /pod_invites.json
  def index
    @pod_outgoing = PodInvite.all.where(inviter: current_user.id)
    @pod_incoming = PodInvite.all.where(invitee: current_user.id)
  end

  # GET /pod_invites/1.json
  def show
  end

  # POST /pod_invites.json
  def create
    @successes = Array.new
    @failures = Array.new
    params[:pod_invite][:sent_to].each do |send_to|
      pod_invite = PodInvite.new(sent_to: send_to, inviter: current_user)
      response = QuadPodService.instance.send_invite(pod_invite)
      if response[:status] == 'success'
        @successes.push(response)
      else
        @failures.push(response)
      end
    end
  end

  def invite_existing_user
    invitee = User.find(params[:id])
    pod_invite = PodInvite.new(invitee_id: invitee.id, inviter: current_user, sent_to: invitee.email)
    response = QuadPodService.instance.send_invite(pod_invite)
    if response[:status] == 'success'
      render json: {}, status: 201
    else
      render json: {errors: response[:message]}, status: 422
    end
  end

  def accept
    QuadPodService.instance.accept_invite_existing_user(@pod_invite)
    @invites = PodInvite.invites_for_user(current_user)
    render action: :invites
  end

  def deny
    QuadPodService.instance.deny_invite(@pod_invite)
    @invites = PodInvite.invites_for_user(current_user)
    render action: :invites
  end

  def invites
    @invites = PodInvite.invites_for_user(current_user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pod_invite
    @pod_invite = PodInvite.find(params[:id])
  end

  def verify_invitee
    return unauthorized unless @pod_invite.invitee_id == current_user.id
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pod_invite_params
    params.require(:pod_invite).permit(:sent_to)
  end
end
