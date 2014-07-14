require 'test_helper'

class CustomExerciseTest < ActiveSupport::TestCase
  test 'should add exercise' do
    exercise = CustomExercise.add_exercise(3, 'test', 4, 3)
    assert(exercise != nil)
  end
end
