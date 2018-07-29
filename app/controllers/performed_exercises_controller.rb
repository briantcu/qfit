# == Schema Information
#
# Table name: performed_exercises
#
#  id                          :integer          not null, primary key
#  routine_id                  :integer
#  exercise_id                 :integer
#  rest_period                 :integer
#  status                      :integer
#  one_rep_max                 :integer
#  group_performed_exercise_id :integer
#  exercise_type_id            :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#

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
    exercise = Exercise.find(params[:performed_exercise][:exercise_id])
    if exercise.paid_tier > current_user.exercise_tier
      render json: { success: false, errors: "You don't have access to that exercise. Please upgrade your subscription." }, :status => 401
      return
    end
    need_to_create_sets = (@performed_exercise.exercise_id != params[:performed_exercise][:exercise_id])
    if @performed_exercise.update_ex(performed_exercise_params, need_to_create_sets)
      @daily_routine = @performed_exercise.daily_routine
      render 'daily_routines/show'
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

    @daily_routine = @performed_exercise.daily_routine
    render 'daily_routines/show'
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
