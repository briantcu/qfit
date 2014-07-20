class PerformedWarmUpsController < ApplicationController
  before_action :set_performed_warm_up, only: [:show, :edit, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update]

  # GET /performed_warm_ups/1
  # GET /performed_warm_ups/1.json
  def show
  end

  # PATCH/PUT /performed_warm_ups/1
  # PATCH/PUT /performed_warm_ups/1.json
  def update
    if @performed_warm_up.update(performed_warm_up_params)
      render action: 'show', status: :ok, location: @performed_warm_up
    else
      render json: @performed_warm_up.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_warm_ups/1
  # DELETE /performed_warm_ups/1.json
  def destroy
    @performed_warm_up.destroy
    respond_to do |format|
      format.html { redirect_to performed_warm_ups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performed_warm_up
      @performed_warm_up = PerformedWarmUp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performed_warm_up_params
      params.require(:performed_warm_up).permit(:routine_id, :warmup_id, :status, :group_warmup_id, :completed)
    end

  def verify_owns_workout
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_workout(params[:performed_warm_up][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
