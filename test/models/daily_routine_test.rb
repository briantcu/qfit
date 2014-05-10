require 'test_helper'

class DailyRoutineTest < ActiveSupport::TestCase
  test 'returns routines for the month' do
    routines = DailyRoutine.get_routines_for_month(1, 4, 2014)
    assert(routines.count == 2)
  end
end
