class UserGoalsController < ApplicationController
  before_filter :verify_logged_in

  def index
    @user_goals = GoalDefinition.all.includes(:user_goals).where('user_goals.user_id = ?', current_user.id).references(:user_goals)
  end

end
