require 'test_helper'

class GroupScheduleDaysControllerTest < ActionController::TestCase
  setup do
    @group_schedule_day = group_schedule_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_schedule_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_schedule_day" do
    assert_difference('GroupScheduleDay.count') do
      post :create, group_schedule_day: { group_schedule_id: @group_schedule_day.group_schedule_id, plyos: @group_schedule_day.plyos, sprinting: @group_schedule_day.sprinting, stretching: @group_schedule_day.stretching, weights: @group_schedule_day.weights }
    end

    assert_redirected_to group_schedule_day_path(assigns(:group_schedule_day))
  end

  test "should show group_schedule_day" do
    get :show, id: @group_schedule_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_schedule_day
    assert_response :success
  end

  test "should update group_schedule_day" do
    patch :update, id: @group_schedule_day, group_schedule_day: { group_schedule_id: @group_schedule_day.group_schedule_id, plyos: @group_schedule_day.plyos, sprinting: @group_schedule_day.sprinting, stretching: @group_schedule_day.stretching, weights: @group_schedule_day.weights }
    assert_redirected_to group_schedule_day_path(assigns(:group_schedule_day))
  end

  test "should destroy group_schedule_day" do
    assert_difference('GroupScheduleDay.count', -1) do
      delete :destroy, id: @group_schedule_day
    end

    assert_redirected_to group_schedule_days_path
  end
end
