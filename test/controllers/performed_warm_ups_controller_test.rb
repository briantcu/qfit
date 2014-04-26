require 'test_helper'

class PerformedWarmUpsControllerTest < ActionController::TestCase
  setup do
    @performed_warm_up = performed_warm_ups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performed_warm_ups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performed_warm_up" do
    assert_difference('PerformedWarmUp.count') do
      post :create, performed_warm_up: { completed: @performed_warm_up.completed, group_warmup_id: @performed_warm_up.group_warmup_id, routine_id: @performed_warm_up.routine_id, status: @performed_warm_up.status, warmup_id: @performed_warm_up.warmup_id }
    end

    assert_redirected_to performed_warm_up_path(assigns(:performed_warm_up))
  end

  test "should show performed_warm_up" do
    get :show, id: @performed_warm_up
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performed_warm_up
    assert_response :success
  end

  test "should update performed_warm_up" do
    patch :update, id: @performed_warm_up, performed_warm_up: { completed: @performed_warm_up.completed, group_warmup_id: @performed_warm_up.group_warmup_id, routine_id: @performed_warm_up.routine_id, status: @performed_warm_up.status, warmup_id: @performed_warm_up.warmup_id }
    assert_redirected_to performed_warm_up_path(assigns(:performed_warm_up))
  end

  test "should destroy performed_warm_up" do
    assert_difference('PerformedWarmUp.count', -1) do
      delete :destroy, id: @performed_warm_up
    end

    assert_redirected_to performed_warm_ups_path
  end
end
