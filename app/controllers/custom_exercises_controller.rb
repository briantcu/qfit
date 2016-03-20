class CustomExercisesController < ApplicationController
  before_action :set_custom_exercise, only: [:show, :edit, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update, :destroy]

  # GET /custom_exercises/1
  # GET /custom_exercises/1.json
  def show
  end

  # PATCH/PUT /custom_exercises/1
  # PATCH/PUT /custom_exercises/1.json
  def update
    respond_to do |format|
      if @custom_exercise.update(custom_exercise_params)
        format.html { redirect_to @custom_exercise, notice: 'Custom exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @custom_exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_exercises/1
  # DELETE /custom_exercises/1.json
  def destroy
    @custom_exercise.destroy
    render json: {success: true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_exercise
      @custom_exercise = CustomExercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_exercise_params
      params.require(:custom_exercise).permit(:rid, :details, :status, :gid, :name, :type)
    end

  def verify_owns_workout
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_workout?(params[:performed_sprint][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
