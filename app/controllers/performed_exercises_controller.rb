class PerformedExercisesController < ApplicationController
  before_action :set_performed_exercise, only: [:show, :edit, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update, :destroy]

  DELETED = 2

  # GET /performed_exercises/1
  # GET /performed_exercises/1.json
  def show
  end

  # PATCH/PUT /performed_exercises/1
  def update
    need_to_create_sets = (@performed_exercise.exercise_id != params[:performed_exercise][:exercise_id])
    if @performed_exercise.update_ex(performed_exercise_params, need_to_create_sets)
      render action: 'show', status: :ok, location: @performed_exercise
    else
      render json: @performed_exercise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /performed_exercises/1
  # DELETE /performed_exercises/1.json
  def destroy
    @performed_exercise.status = DELETED
    @performed_exercise.save
    @performed_exercise.daily_routine.note_weights_changed
    render json: {success: true}
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_performed_exercise
    @performed_exercise = PerformedExercise.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def performed_exercise_params
    params.require(:performed_exercise).permit(:routine_id, :exercise_id, :rest_period, :status, :one_rep_max,
                                               :group_performed_exercise_id, :exercise_type)
  end

  def verify_owns_workout
    (current_user.nil?) ? unauthorized : unauthorized unless
        (current_user.owns_workout?(params[:performed_exercise][:routine_id]))
  end

  def unauthorized
    render json: { success: false, errors: 'Unauthorized' }, :status => :unauthorized
  end
end
