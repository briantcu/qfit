# == Schema Information
#
# Table name: group_performed_sprints
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  status     :integer
#  routine_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupPerformedSprintsController < ApplicationController
  before_filter :verify_logged_in
  before_action :set_group_performed_sprint, only: [:update, :destroy]
  before_filter :verify_owns_group, only: [:update, :destroy]

  # PATCH/PUT /group_performed_sprints/1
  # PATCH/PUT /group_performed_sprints/1.json
  def update
    if @group_performed_sprint.sprint_id != params[:group_performed_sprint][:sprint_id]
      @group_performed_sprint.update_ex(group_performed_sprint_params)
      @group_routine = @group_performed_sprint.group_routine
      render 'group_routines/show'
    else
      render json: @group_performed_sprint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_performed_sprints/1
  # DELETE /group_performed_sprints/1.json
  def destroy
    @group_performed_sprint.destroy_ex
    @group_routine = @group_performed_sprint.group_routine
    render 'group_routines/show'
  end

  private
  def set_group_performed_sprint
    @group_performed_sprint = GroupPerformedSprint.find(params[:id])
  end

  def group_performed_sprint_params
    params.require(:group_performed_sprint).permit(:sprint_id)
  end

  def verify_owns_group
    unauthorized unless (current_user.owns_group?(@group_performed_sprint.routine_id))
  end
end
