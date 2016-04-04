class CustomExercisesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_custom_exercise, only: [:destroy]
  before_filter :verify_owns_group, only: [:destroy]

  # DELETE /custom_exercises/1.json
  def destroy
    @custom_exercise.destroy
    render json: {success: true}
  end

  private
  def set_group_custom_exercise
    @custom_exercise = CustomExercise.find(params[:id])
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_group?(@custom_exercise.routine_id))
  end
end
