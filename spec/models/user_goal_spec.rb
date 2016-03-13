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

require 'rails_helper'

RSpec.describe UserGoal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
