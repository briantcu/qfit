require 'test_helper'

class PerformedWarmUpTest < ActiveSupport::TestCase
  test 'adds exercise' do
    exercise = PerformedWarmUp.add_exercise(3, 2, 1, 4)
    assert(exercise != nil)
  end
end
