require 'test_helper'

class DailyRoutineTest < ActiveSupport::TestCase
  test 'returns routines for the month' do
    routines = DailyRoutine.get_routines_for_month(1, 4, 2014)
    assert(routines.count == 5)
  end

  test 'finds matching weights routine' do
    date = Date.new(2014, 4, 21)
    matching = DailyRoutine.get_matching_routine_since(date, 1, 1, 1)
    assert(matching.user_id == 1)
  end

  test 'gets user routine from group routine and id' do
    routine = DailyRoutine.get_routine_from_group_routine_id(2, 1, 1)
    assert(routine.id == 2)
  end

  test 'gets warmups without changes saved' do
    routine = DailyRoutine.find(3)
    exercises = routine.get_warmups_without_changes_saved
    assert(exercises.count == 2)
  end

  test 'adds sprint' do
    routine = DailyRoutine.find(3)
    routine.add_sprint(2 ,3, 2)
    assert(routine.performed_sprints.count == 1)
    assert(routine.performed_sprints.first.laps.count == 3)
  end

  test 'get custom exercises with filter' do
    routine = DailyRoutine.find(3)
    exes = routine.get_custom_exercises(2)
    assert(exes.count == 2)
  end

  test 'should calculate num of completed plyos' do
    routine = DailyRoutine.find(1)
    num = routine.get_num_completed_plyos
    assert(num == 1)
    end

  test 'should calculate num of completed warmups' do
    routine = DailyRoutine.find(3)
    num = routine.get_num_completed_warmups
    assert(num == 1)
  end

  test 'should calculate num of completed laps' do
    routine = DailyRoutine.find(1)
    num = routine.get_num_completed_laps
    assert(num == 1)
  end

  test 'should calculate num of completed sets' do
    routine = DailyRoutine.find(1)
    num = routine.get_num_completed_weight_sets
    assert(num == 3)
  end

  test 'should calculate num of provided plyos' do
    routine = DailyRoutine.find(1)
    num = routine.get_num_provided_plyos
    assert(num == 3)
  end

  test 'should calculate num of provided warmups' do
    routine = DailyRoutine.find(3)
    num = routine.get_num_provided_warmups
    assert(num == 1)
  end

  test 'should calculate num of provided laps' do
    routine = DailyRoutine.find(1)
    num = routine.get_num_provided_laps
    assert(num == 2)
  end

  test 'should calculate num of provided sets' do
    routine = DailyRoutine.find(1)
    num = routine.get_num_provided_weight_sets
    assert(num == 4)
  end

  test 'should get old open workouts for user' do
    workouts = DailyRoutine.get_old_open_workouts_for_user(1)
    assert(workouts.count == 5)
  end


end
