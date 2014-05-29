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


end
