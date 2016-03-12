class PodInvitesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_pod_invite, only: [:show, :edit, :update, :destroy]

  # GET /pod_invites
  # GET /pod_invites.json
  def index
    @pod_invites = PodInvite.all.where(inviter: current_user.id)
  end

  # GET /pod_invites/1
  # GET /pod_invites/1.json
  def show
  end

  # GET /pod_invites/new
  def new
    @pod_invite = PodInvite.new
  end

  # GET /pod_invites/1/edit
  def edit
  end

  # POST /pod_invites
  # POST /pod_invites.json
  def create
    @pod_invite = PodInvite.new(pod_invite_params)

    respond_to do |format|
      if @pod_invite.save
        format.html { redirect_to @pod_invite, notice: 'Pod invite was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pod_invite }
      else
        format.html { render action: 'new' }
        format.json { render json: @pod_invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pod_invites/1
  # PATCH/PUT /pod_invites/1.json
  def update
    respond_to do |format|
      if @pod_invite.update(pod_invite_params)
        format.html { redirect_to @pod_invite, notice: 'Pod invite was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pod_invite.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pod_invites/1
  # DELETE /pod_invites/1.json
  def destroy
    @pod_invite.destroy
    respond_to do |format|
      format.html { redirect_to pod_invites_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pod_invite
      @pod_invite = PodInvite.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pod_invite_params
      params.require(:pod_invite).permit(:inviter, :sent_to, :status, :invitee)
    end
end
