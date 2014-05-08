require 'test_helper'
include Devise::TestHelpers

class UserSchedulesControllerTest < ActionController::TestCase
  setup do
  end

  test 'should create a new user schedule' do
    user = users(:two)
    sign_in user

    post(:create, user_schedule: { user_id: 2, program_id: 3, program_type_id: 2})
    assert_response :created
    assert(@controller.instance_variable_get(:@user_schedule).id != nil)
    assert(@controller.instance_variable_get(:@user_schedule).sign_up_date == Date.current)
    assert(@controller.instance_variable_get(:@user_schedule).phase_one_start == Date.current)
    assert(user.current_phase == @controller.instance_variable_get(:@user_schedule).get_current_phase)
    assert(user.program_type == @controller.instance_variable_get(:@user_schedule).program_type)

  end

  test 'should update an existing user schedule' do
    user = users(:one)
    sign_in user
    post(:create, user_schedule: { user_id: 1, program_id: 3, program_type_id: 2})
    assert_response :ok
    assert(@controller.instance_variable_get(:@user_schedule).id != nil)
    assert(user.current_phase == @controller.instance_variable_get(:@user_schedule).get_current_phase)
    assert(@controller.instance_variable_get(:@user_schedule).phase_one_start == Date.current)
    assert(user.program_type == @controller.instance_variable_get(:@user_schedule).program_type)
  end

  test 'should not allow updating a user schedule when user ids dont match' do
    user = users(:two)
    sign_in user
    post(:create, user_schedule: { user_id: 1, program_id: 3, program_type_id: 2})
    assert_response 401
  end

  test 'should allow updating for super user' do
    user = users(:super)
    sign_in user
    post(:create, user_schedule: { user_id: 1, program_id: 3, program_type_id: 2})
    assert_response :ok
  end

  test 'should not allow updating for mismatch coach/sub ' do
    user = users(:coach)
    sign_in user
    post(:create, user_schedule: { user_id: 1, program_id: 3, program_type_id: 2})
    assert_response 401
  end

  test 'should allow updating for matching coach/sub ' do
    user = users(:coach)
    sign_in user
    post(:create, user_schedule: { user_id: 5, program_id: 3, program_type_id: 2})
    assert_response :created
  end

end
