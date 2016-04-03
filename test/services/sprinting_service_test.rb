require 'test_helper'

class SprintingServiceTest < ActiveSupport::TestCase

  test 'should add sprint for user' do
    routine = DailyRoutine.find(6)
    user = User.find(1)
    SprintingService.instance.add_exercises(user, routine)
    assert(routine.performed_sprints.count == 1)
  end

  test 'should add sprint for group' do
    routine = GroupRoutine.find(3)
    group = Group.find(1)
    SprintingService.instance.add_exercises(group, routine)
    assert(routine.group_performed_sprints.count == 1)
  end

end