require 'test_helper'

class UserSchedulesControllerTest < ActionController::TestCase
  setup do
    @user_schedule = user_schedules(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_schedules)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_schedule" do
    assert_difference('UserSchedule.count') do
      post :create, user_schedule: { phase_four_start: @user_schedule.phase_four_start, phase_one_start: @user_schedule.phase_one_start, phase_three_start: @user_schedule.phase_three_start, phase_two_start: @user_schedule.phase_two_start, program_id: @user_schedule.program_id, program_type: @user_schedule.program_type, sign_up_date: @user_schedule.sign_up_date, user_id: @user_schedule.user_id }
    end

    assert_redirected_to user_schedule_path(assigns(:user_schedule))
  end

  test "should show user_schedule" do
    get :show, id: @user_schedule
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_schedule
    assert_response :success
  end

  test "should update user_schedule" do
    patch :update, id: @user_schedule, user_schedule: { phase_four_start: @user_schedule.phase_four_start, phase_one_start: @user_schedule.phase_one_start, phase_three_start: @user_schedule.phase_three_start, phase_two_start: @user_schedule.phase_two_start, program_id: @user_schedule.program_id, program_type: @user_schedule.program_type, sign_up_date: @user_schedule.sign_up_date, user_id: @user_schedule.user_id }
    assert_redirected_to user_schedule_path(assigns(:user_schedule))
  end

  test "should destroy user_schedule" do
    assert_difference('UserSchedule.count', -1) do
      delete :destroy, id: @user_schedule
    end

    assert_redirected_to user_schedules_path
  end
end
