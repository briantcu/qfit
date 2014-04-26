require 'test_helper'

class WeeklyScheduleDaysControllerTest < ActionController::TestCase
  setup do
    @weekly_schedule_day = weekly_schedule_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekly_schedule_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekly_schedule_day" do
    assert_difference('WeeklyScheduleDay.count') do
      post :create, weekly_schedule_day: { day: @weekly_schedule_day.day, plyometrics: @weekly_schedule_day.plyometrics, sprinting: @weekly_schedule_day.sprinting, stretching: @weekly_schedule_day.stretching, user_schedule_id: @weekly_schedule_day.user_schedule_id, weights: @weekly_schedule_day.weights }
    end

    assert_redirected_to weekly_schedule_day_path(assigns(:weekly_schedule_day))
  end

  test "should show weekly_schedule_day" do
    get :show, id: @weekly_schedule_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weekly_schedule_day
    assert_response :success
  end

  test "should update weekly_schedule_day" do
    patch :update, id: @weekly_schedule_day, weekly_schedule_day: { day: @weekly_schedule_day.day, plyometrics: @weekly_schedule_day.plyometrics, sprinting: @weekly_schedule_day.sprinting, stretching: @weekly_schedule_day.stretching, user_schedule_id: @weekly_schedule_day.user_schedule_id, weights: @weekly_schedule_day.weights }
    assert_redirected_to weekly_schedule_day_path(assigns(:weekly_schedule_day))
  end

  test "should destroy weekly_schedule_day" do
    assert_difference('WeeklyScheduleDay.count', -1) do
      delete :destroy, id: @weekly_schedule_day
    end

    assert_redirected_to weekly_schedule_days_path
  end
end
