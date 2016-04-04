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

class UserGoal < ActiveRecord::Base
  has_one :user
  has_one :goal_definition
end
