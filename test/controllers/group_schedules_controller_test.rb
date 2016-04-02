# == Schema Information
#
# Table name: group_schedules
#
#  id                :integer          not null, primary key
#  group_id          :integer
#  program_id        :integer
#  phase_one_start   :date
#  phase_two_start   :date
#  phase_three_start :date
#  phase_four_start  :date
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'
include Devise::TestHelpers

class GroupSchedulesControllerTest < ActionController::TestCase
  test 'should create a new group schedule' do
    user = users(:coach)
    sign_in user

    post(:create, group_schedule: { group_id: 3, program_id: 3})
    assert_response :created
    assert(@controller.instance_variable_get(:@group_schedule).id != nil)
    assert(@controller.instance_variable_get(:@group_schedule).phase_one_start == Date.current)
    assert(@controller.instance_variable_get(:@group_schedule).group.current_phase ==
               @controller.instance_variable_get(:@group_schedule).get_current_phase)
  end

  test 'should update an existing group schedule' do
    user = users(:coach)
    sign_in user
    RoutineService.any_instance.stubs(:create_routines).returns(true)
    post(:create, group_schedule: { group_id: 1, program_id: 3, program_type_id: 2})
    assert_response :ok
    assert(@controller.instance_variable_get(:@group_schedule).id != nil)
    assert(@controller.instance_variable_get(:@group_schedule).phase_one_start == Date.current)
    assert(@controller.instance_variable_get(:@group_schedule).group.current_phase ==
               @controller.instance_variable_get(:@group_schedule).get_current_phase)
  end

  test 'should not allow updating a group schedule when coach does not own group' do
    user = users(:sub)
    sign_in user
    post(:create, group_schedule: { group_id: 1, program_id: 3})
    assert_response 401
  end

  test 'should allow updating for super user' do
    user = users(:super)
    sign_in user
    RoutineService.any_instance.stubs(:create_routines).returns(true)
    post(:create, group_schedule: { group_id: 1, program_id: 3})
    assert_response :ok
  end

end
