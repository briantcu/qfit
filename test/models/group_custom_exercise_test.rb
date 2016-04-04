require 'test_helper'

class GroupCustomExerciseTest < ActiveSupport::TestCase
  test 'should add exercise' do
    exercise = GroupCustomExercise.add_exercise(3, 'test', 4)
    assert(exercise != nil)
  end
end
