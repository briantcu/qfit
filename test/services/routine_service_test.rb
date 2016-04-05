require 'test_helper'

class RoutineServiceTest < ActiveSupport::TestCase

  test 'should do nothing with nil user' do
    @user = User.new
    @routine_service = RoutineService.new(@user, 'Cron', Date.today, false)
    routine = @routine_service.create_routine
    assert(routine == nil)
  end

  test 'should do nothing with routine on date already' do
    date = Date.new(2014, 4, 26)
    @user = User.find(1)
    @routine_service = RoutineService.new(@user, 'CRON', date, false)
    routine = @routine_service.create_routine
    assert(routine == nil)
  end

  test 'should return next stretching day for non sched update' do
    date = Date.new(2014, 4, 26)
    @user = User.find(2)
    @routine_service = RoutineService.new(@user, 'CRON', date, false)
    next_day = @routine_service.get_next_day_id(4)
    assert(next_day == 2)
  end

  test 'should return next weights day for non sched update and wrap around' do
    date = Date.new(2014, 4, 26)
    @user = User.find(2)
    @routine_service = RoutineService.new(@user, 'CRON', date, false)
    next_day = @routine_service.get_next_day_id(2)
    assert(next_day == 1)
  end

  test 'should return next plyos day for non sched update' do
    date = Date.new(2014, 4, 26)
    @user = User.find(2)
    @routine_service = RoutineService.new(@user, 'CRON', date, false)
    next_day = @routine_service.get_next_day_id(2)
    assert(next_day == 1)
  end

  test 'should return next sprinting day for non sched update' do
    date = Date.new(2014, 3, 26)
    @user = User.find(2)
    @routine_service = RoutineService.new(@user, 'CRON', date, false)
    next_day = @routine_service.get_next_day_id(3)
    assert(next_day == 2)
  end

  test 'should return next stretching day for sched update' do
    date = Date.new(2014, 4, 26)
    @user = User.find(2)
    @routine_service = RoutineService.new(@user, 'CRON', date, true)
    next_day = @routine_service.get_next_day_id(4)
    assert(next_day == 1)
  end

  test 'should create routine with canned warm ups and pull custom exercises from previous workout' do
    date = Date.new(2014, 5, 18)
    @user = User.find(1)
    @routine_service = RoutineService.new(@user, 'CRON', date, false)
    routine = @routine_service.create_routine
    assert(routine.performed_plyometrics.count == 4)
    assert(routine.performed_warm_ups.count == 6)
    assert(routine.performed_sprints.count == 1)
    assert(routine.performed_exercises.count == 2)
  end
end