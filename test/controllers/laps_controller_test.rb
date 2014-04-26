require 'test_helper'

class LapsControllerTest < ActionController::TestCase
  setup do
    @lap = laps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:laps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lap" do
    assert_difference('Lap.count') do
      post :create, lap: { completed: @lap.completed, lap_number: @lap.lap_number, performed_sprint_id: @lap.performed_sprint_id }
    end

    assert_redirected_to lap_path(assigns(:lap))
  end

  test "should show lap" do
    get :show, id: @lap
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lap
    assert_response :success
  end

  test "should update lap" do
    patch :update, id: @lap, lap: { completed: @lap.completed, lap_number: @lap.lap_number, performed_sprint_id: @lap.performed_sprint_id }
    assert_redirected_to lap_path(assigns(:lap))
  end

  test "should destroy lap" do
    assert_difference('Lap.count', -1) do
      delete :destroy, id: @lap
    end

    assert_redirected_to laps_path
  end
end
