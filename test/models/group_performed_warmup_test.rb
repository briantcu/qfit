require 'test_helper'

class GroupPerformedWarmupTest < ActiveSupport::TestCase
  test 'adds exercise' do
    exercise = GroupPerformedWarmup.add_exercise(3, 2, 1)
    assert(exercise != nil)
  end
end

# == Schema Information
#
# Table name: group_performed_warmups
#
#  id         :integer          not null, primary key
#  routine_id :integer
#  warmup_id  :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#
