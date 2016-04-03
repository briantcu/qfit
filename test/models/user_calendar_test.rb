require 'test_helper'

class UserCalendarTest < ActiveSupport::TestCase

  test 'processes submission correctly' do
    calendar = UserCalendar.new(:user_id => 1, :year_id => 2014, :month_id => 4)

    calendar.populate_calendar

    active_day = calendar.calendar_month.days.find { |item|
      'active' == item.workout_status
    }

    assert(active_day.day_of_month == 24)
  end

  test 'finds routine for date' do
    calendar = UserCalendar.new(:user_id => 1, :year_id => 2014, :month_id => 4)
    routines = DailyRoutine.where(:user_id => 1)
    routine = calendar.find_routine_for_date(routines, Date.new(2014, 4, 26))
    assert(routine != nil)
  end

end