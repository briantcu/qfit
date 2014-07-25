class GroupPerformedSprintsController < ApplicationController
  before_action :set_group_performed_sprint, only: [:show, :update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # GET /group_performed_sprints/1
  # GET /group_performed_sprints/1.json
  def show
  end

  # PATCH/PUT /group_performed_sprints/1
  # PATCH/PUT /group_performed_sprints/1.json
  def update
    if @group_performed_sprint.sprint_id != params[:group_performed_sprint][:sprint_id]
      @group_performed_sprint.update_ex(group_performed_sprint_params)
      render action: 'show', status: :ok, location: @group_performed_sprint
    else
      render json: @group_performed_sprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_sprints/1
  # DELETE /group_performed_sprints/1.json
  def destroy
    @group_performed_sprint.destroy_ex
    render json: {success: true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_sprint
      @group_performed_sprint = GroupPerformedSprint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_sprint_params
      params.require(:group_performed_sprint).permit(:sprint_id, :status, :routine_id)
    end

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_group(params[:group_performed_sprint][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
