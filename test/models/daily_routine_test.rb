require 'test_helper'

class DailyRoutineTest < ActiveSupport::TestCase
  test 'returns routines for the month' do
    routines = DailyRoutine.get_routines_for_month(1, 4, 2014)
    assert(routines.count == 2)
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
    assert(exercises.size == 2)
  end
end
