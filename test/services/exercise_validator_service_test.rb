require 'test_helper'

class ExerciseValidatorServiceTest < ActiveSupport::TestCase

  test 'be valid for non body weight exercises' do
    routine = DailyRoutine.new
    user = User.new
    user.power_index = 100
    exercise = Exercise.new
    exercise.is_body_weight = false
    valid = ExerciseValidatorService.instance.is_valid_exercise(user, routine, exercise)
    assert(valid)
  end

  test 'be valid for body weight exercise and strong user' do
    routine = DailyRoutine.new
    user = User.new
    user.weight = 100
    user.power_index = 30
    exercise = Exercise.new
    exercise.is_body_weight = true
    exercise.id = 55
    valid = ExerciseValidatorService.instance.is_valid_exercise(user, routine, exercise)
    assert(valid)
  end

  test 'be invalid for body weight exercise and weak user' do
    routine = DailyRoutine.new
    user = User.new
    user.weight = 100
    user.power_index = 3
    exercise = Exercise.new
    exercise.is_body_weight = true
    exercise.id = 55
    valid = ExerciseValidatorService.instance.is_valid_exercise(user, routine, exercise)
    assert(!valid)
  end

end