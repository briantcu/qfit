# == Schema Information
#
# Table name: custom_exercises
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  details    :string(255)
#  status     :integer
#  group_id   :integer
#  name       :string(255)
#  ex_type    :integer
#  created_at :datetime
#  updated_at :datetime
#

class CustomExercisesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_custom_exercise, only: [:destroy]
  before_filter :verify_owns_group, only: [:destroy]

  # DELETE /custom_exercises/1.json
  def destroy
    @custom_exercise.destroy
    @daily_routine = @custom_exercise.daily_routine
    render 'daily_routines/show'
  end

  private
  def set_group_custom_exercise
    @custom_exercise = CustomExercise.find(params[:id])
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_workout?(@custom_exercise.routine_id))
  end
end
