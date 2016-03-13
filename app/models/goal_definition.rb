# == Schema Information
#
# Table name: goal_definitions
#
#  id            :integer          not null, primary key
#  order         :integer
#  goal_text     :text
#  achieved_text :text
#  points        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class GoalDefinition < ActiveRecord::Base
  has_many :user_goals
end
