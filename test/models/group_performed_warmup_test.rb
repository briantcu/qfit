require 'test_helper'

class GroupPerformedWarmupTest < ActiveSupport::TestCase
  test 'adds exercise' do
    exercise = GroupPerformedWarmup.add_exercise(3, 2, 1)
    assert(exercise != nil)
  end
end
