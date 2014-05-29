require 'test_helper'

class RoutineServiceTest < ActiveSupport::TestCase

  setup do

  end

  test 'should do nothing with nil user' do
    @user = User.new
    @routine_service = RoutineService.new(@user, 'Cron', Date.today)
    routine = @routine_service.create_routine
    assert(routine == nil)
  end

  test 'should do nothing with routine on date already' do
    date = Date.new(2014, 4, 26)
    @user = User.find(1)
    @routine_service = RoutineService.new(@user, 'CRON', date)
    routine = @routine_service.create_routine
    assert(routine == nil)
  end

  test 'should create a routine' do
    date = Date.new(2014, 4, 27)
    @user = User.find(1)
    @routine_service = RoutineService.new(@user, 'CRON', date)
    routine = @routine_service.create_routine
    assert(routine != nil)
  end

end