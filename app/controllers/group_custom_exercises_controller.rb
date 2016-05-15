# == Schema Information
#
# Table name: group_custom_exercises
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  details    :text
#  status     :integer
#  name       :string(255)
#  ex_type    :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupCustomExercisesController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_custom_exercise, only: [:show, :destroy]
  before_filter :verify_owns_group, only: [:destroy]

  # DELETE /group_custom_exercises/1.json
  def destroy
    @group_custom_exercise.destroy_ex
    render json: {success: true}
  end

  private
  def set_group_custom_exercise
    @group_custom_exercise = GroupCustomExercise.find(params[:id])
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_group?(@group_custom_exercise.routine_id))
  end
end
