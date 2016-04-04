class UserGoal < ActiveRecord::Base
  has_one :user
  has_one :goal_definition
end
