# == Schema Information
#
# Table name: user_goals
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  goal_definition_id :integer
#  value              :json
#  created_at         :datetime
#  updated_at         :datetime
#

class UserGoalsController < ApplicationController
  before_filter :verify_logged_in

  def index
    @user_goals = GoalDefinition.all.includes(:user_goals).where('user_goals.user_id = ?', current_user.id).references(:user_goals)
  end

end
