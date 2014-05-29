require 'test_helper'

class UserScheduleTest < ActiveSupport::TestCase

  test 'should setup phases' do
    user_schedule = UserSchedule.new
    user_schedule.setup_phases
    assert(user_schedule.phase_one_start == Date.current)
    assert(user_schedule.phase_two_start == Date.current.advance(:weeks => 3))
    assert(user_schedule.phase_three_start == Date.current.advance(:weeks => 6))
    assert(user_schedule.phase_four_start == Date.current.advance(:weeks => 9))
  end

  test 'should create weekly schedule days' do
    user_schedule = user_schedules(:two)
    assert(user_schedule.weekly_schedule_days.count == 0)
    user_schedule.create_weekly_schedule_days
    assert(user_schedule.weekly_schedule_days.count == 7)
  end

  test 'should create user schedule' do
    user_schedule = UserSchedule.create_user_schedule({ user_id: 1, program_id: 3, program_type_id: 2})
    assert(user_schedule.user_id == 1)
    assert(user_schedule.program_id == 3)
    assert(user_schedule.program_type_id == 2)
  end

  test 'should return current phase' do
    user_schedule = UserSchedule.new
    user_schedule.setup_phases
    assert(user_schedule.get_current_phase == 1)
  end

  test 'should maintain phases' do
    user_schedule = UserSchedule.find(2)
    date = Date.new(2014, 5, 18)
    phase = user_schedule.maintain_phases(date)
    assert(phase == 1)
    assert(user_schedule.phase_one_start == Date.new(2014, 5, 17))
  end
end
