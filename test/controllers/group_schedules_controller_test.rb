require 'test_helper'

class GroupSchedulesControllerTest < ActionController::TestCase
  setup do
    @group_schedule = group_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_schedule" do
    assert_difference('GroupSchedule.count') do
      post :create, group_schedule: { group_id: @group_schedule.group_id, phase_four_start: @group_schedule.phase_four_start, phase_one_start: @group_schedule.phase_one_start, phase_three_start: @group_schedule.phase_three_start, phase_two_start: @group_schedule.phase_two_start, program_id: @group_schedule.program_id }
    end

    assert_redirected_to group_schedule_path(assigns(:group_schedule))
  end

  test "should show group_schedule" do
    get :show, id: @group_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_schedule
    assert_response :success
  end

  test "should update group_schedule" do
    patch :update, id: @group_schedule, group_schedule: { group_id: @group_schedule.group_id, phase_four_start: @group_schedule.phase_four_start, phase_one_start: @group_schedule.phase_one_start, phase_three_start: @group_schedule.phase_three_start, phase_two_start: @group_schedule.phase_two_start, program_id: @group_schedule.program_id }
    assert_redirected_to group_schedule_path(assigns(:group_schedule))
  end

  test "should destroy group_schedule" do
    assert_difference('GroupSchedule.count', -1) do
      delete :destroy, id: @group_schedule
    end

    assert_redirected_to group_schedules_path
  end
end
