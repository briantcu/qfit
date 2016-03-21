class GroupPerformedPlyosController < ApplicationController
  before_action :set_group_performed_plyo, only: [:show, :update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # GET /group_performed_plyos/1
  # GET /group_performed_plyos/1.json
  def show
  end

  # PATCH/PUT /group_performed_plyos/1
  # PATCH/PUT /group_performed_plyos/1.json
  def update
    if @group_performed_plyo.plyometric_id != params[:group_performed_plyo][:plyometric_id]
      @group_performed_plyo.update_ex(group_performed_plyo_params)
      render action: 'show', status: :ok, location: @group_performed_plyo
    else
      render json: @group_performed_plyo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_plyos/1
  # DELETE /group_performed_plyos/1.json
  def destroy
    @group_performed_plyo.destroy_ex
    render json: {success: true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_performed_plyo
      @group_performed_plyo = GroupPerformedPlyo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_performed_plyo_params
      params.require(:group_performed_plyo).permit(:plyometric_id, :status)
    end

  def verify_owns_group
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_group?(@group_performed_plyo.routine_id))
  end
end
