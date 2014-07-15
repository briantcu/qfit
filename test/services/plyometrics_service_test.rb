require 'test_helper'

class PlyometricsServiceTest < ActiveSupport::TestCase

  test 'should add 4 random plyos for user' do
    routine = DailyRoutine.find(6)
    user = User.find(1)
    PlyometricsService.add_exercises(user, routine)
    assert(routine.performed_plyometrics.size == 4)
  end

  test 'should add 4 random plyos for group' do
    routine = GroupRoutine.find(3)
    group = Group.find(1)
    PlyometricsService.add_exercises(group, routine)
    assert(routine.group_performed_plyos.size == 4)
  end

end