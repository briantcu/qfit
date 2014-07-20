require 'test_helper'

class CloseRoutineServiceTest < ActiveSupport::TestCase

  test 'should close workout' do
    routine = DailyRoutine.find(1)
    service = CloseRoutineService.new(routine)
    assert(!routine.closed)
    routine = service.close_routine
    assert(routine != nil)
    assert(routine.closed)
    assert(routine.user.weight == routine.weight)
    assert(routine.count_ex_provided == 11)
    assert(routine.count_ex_completed == 5)
    assert(routine.power_index != 0)
    assert(routine.user.hor_push_max > 2)
    assert(routine.user.hor_pull_max > 2)
    assert(routine.user.knee_dom_max > 2)
  end

  test 'should skip workout' do
    routine = DailyRoutine.find(1)
    service = CloseRoutineService.new(routine)
    assert(!routine.closed)
    routine = service.skip_routine
    assert(routine != nil)
    assert(routine.closed)
    assert(routine.count_ex_provided == 11)
    assert(routine.count_ex_completed == 0)
  end


end