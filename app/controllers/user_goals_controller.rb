class UserGoalsController < ApplicationController
  before_filter :verify_logged_in
  #before_action :set_user_goal, only: [:show, :edit, :update]

  def index
    @user_goals = GoalDefinition.all.includes(:user_goals).where('user_goals.user_id = ?', current_user.id).references(:user_goals)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_goal
    @user_goal = UserGoal.find(params[:id])
  end
end
