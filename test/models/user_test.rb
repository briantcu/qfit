require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should create a workout routine according to schedule' do
    user = User.find(1)
    routine = user.create_routine(Date.new(2014, 4, 27))
    assert(routine != nil)
  end

  test 'should not create a workout routine if there is not one scheduled' do
    user = User.find(1)
    routine = user.create_routine(Date.new(2014, 4, 28))
    assert(routine.nil?)
  end

  test 'should note day created' do
    user = User.find(1)
    user.note_last_day_created(2, 1)
    assert(user.last_weight_day_created == 2)

    user.note_last_day_created(2, 2)
    assert(user.last_plyometric_day_created == 2)

    user.note_last_day_created(2, 3)
    assert(user.last_sprint_day_created == 2)

    user.note_last_day_created(2, 4)
    assert(user.last_warmup_day_created == 2)
  end


end
