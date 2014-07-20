class PerformedPlyometricsController < ApplicationController
  before_action :set_performed_plyometric, only: [:show, :edit, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update]

  # GET /performed_plyometrics/1
  # GET /performed_plyometrics/1.json
  def show
  end

  # PATCH/PUT /performed_plyometrics/1
  # PATCH/PUT /performed_plyometrics/1.json
  def update
    if @performed_plyometric.update(performed_plyometric_params)
      render action: 'show', status: :ok, location: @performed_plyometric
    else
      render json: @performed_plyometric.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_plyometrics/1
  # DELETE /performed_plyometrics/1.json
  def destroy
    @performed_plyometric.destroy
    respond_to do |format|
      format.html { redirect_to performed_plyometrics_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performed_plyometric
      @performed_plyometric = PerformedPlyometric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def performed_plyometric_params
      params.require(:performed_plyometric).permit(:plyometric_id, :routine_id, :status, :group_performed_plyometric_id, :performed_one, :performed_two, :performed_three)
    end

  def verify_owns_workout
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_workout(params[:performed_plyometric][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
