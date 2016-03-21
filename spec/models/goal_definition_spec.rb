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
#  goal_type     :integer
#

require 'rails_helper'

RSpec.describe GoalDefinition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
