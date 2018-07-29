# == Schema Information
#
# Table name: group_performed_exercises
#
#  id               :integer          not null, primary key
#  routine_id       :integer
#  exercise_id      :integer
#  status           :integer
#  exercise_type_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class GroupPerformedExercisesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_performed_exercise, only: [:update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # PATCH/PUT /group_performed_exercises/1.json
  def update
    if @group_performed_exercise.exercise_id != params[:group_performed_exercise][:exercise_id]
      @group_performed_exercise.update_ex(group_performed_exercise_params)
      @group_routine = @group_performed_exercise.group_routine
      render 'group_routines/show'
    else
      render json: @group_performed_exercise.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_exercises/1.json
  def destroy
    @group_performed_exercise.destroy_ex
    @group_routine = @group_performed_exercise.group_routine
    render 'group_routines/show'
  end

  private
  def set_group_performed_exercise
    @group_performed_exercise = GroupPerformedExercise.find(params[:id])
  end

  def group_performed_exercise_params
    params.require(:group_performed_exercise).permit(:exercise_id)
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_group?(@group_performed_exercise.routine_id))
  end
end
