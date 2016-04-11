require 'test_helper'

class UserScheduleTest < ActiveSupport::TestCase

  test 'should setup phases' do
    user_schedule = UserSchedule.new
    user_schedule.setup_phases
    assert(user_schedule.phase_one_start == Date.today)
    assert(user_schedule.phase_two_start == Date.today.advance(:weeks => 3))
    assert(user_schedule.phase_three_start == Date.today.advance(:weeks => 6))
    assert(user_schedule.phase_four_start == Date.today.advance(:weeks => 9))
  end

  test 'should create weekly schedule days' do
    user_schedule = FactoryGirl.create(:user_schedule)
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
end
