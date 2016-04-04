class PodInvitesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_pod_invite, only: [:show, :accept, :deny]

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
    @pod_invite = PodInvite.new(pod_invite_params)
    @pod_invite.inviter = current_user
    response = QuadPodService.instance.send_invite(@pod_invite)

    if response[:status] == 'success'
      render action: 'show', status: :created, location: response[:pod_invite]
    else
      render status: 400, json: { 'message' => response[:message] }
    end
  end

  def accept
    QuadPodService.instance.accept_invite_existing_user(@pod_invite)
    render status: 201, json: {}
  end

  def deny
    QuadPodService.instance.deny_invite(@pod_invite)
    render status: 201, json: {}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_pod_invite
    @pod_invite = PodInvite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def pod_invite_params
    params.require(:pod_invite).permit(:sent_to)
  end
end
