class GroupPerformedWarmupsController < ApplicationController
  before_action :set_group_performed_warmup, only: [:show, :update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # GET /group_performed_warmups/1
  # GET /group_performed_warmups/1.json
  def show
  end

  # PATCH/PUT /group_performed_warmups/1
  # PATCH/PUT /group_performed_warmups/1.json
  def update
    if @group_performed_warmup.warmup_id != params[:group_performed_warmup][:warmup_id]
      @group_performed_warmup.update_ex(group_performed_warmup_params)
      render action: 'show', status: :ok, location: @group_performed_warmup
    else
      render json: @group_performed_warmup.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_warmups/1
  # DELETE /group_performed_warmups/1.json
  def destroy
    @group_performed_warmup.destroy_ex
    render json: {success: true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_warmup
      @group_performed_warmup = GroupPerformedWarmup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_warmup_params
      params.require(:group_performed_warmup).permit(:routine_id, :warmup_id, :status)
    end

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_group(params[:group_performed_warmup][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
