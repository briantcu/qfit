class PerformedExercisesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_performed_exercise, only: [:show, :update, :destroy]
  before_filter :verify_owns_workout, only: [:update, :destroy]

  DELETED = 2

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

  # DELETE /performed_exercises/1.json
  def destroy
    if @performed_exercise.status == 1 #Added exercise
      @performed_exercise.destroy
    else
      @performed_exercise.update_attributes(status: DELETED)
      @performed_exercise.daily_routine.note_weights_changed
    end

    render json: {success: true}
  end

  private
  def set_performed_exercise
    @performed_exercise = PerformedExercise.find(params[:id])
  end

  def performed_exercise_params
    params.require(:performed_exercise).permit(:exercise_id)
  end

  def verify_owns_workout
    unauthorized unless (current_user.owns_workout?(@performed_exercise.routine_id))
  end
end
