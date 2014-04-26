require 'test_helper'

class GroupPerformedWarmupsControllerTest < ActionController::TestCase
  setup do
    @group_performed_warmup = group_performed_warmups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_performed_warmups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_performed_warmup" do
    assert_difference('GroupPerformedWarmup.count') do
      post :create, group_performed_warmup: { routine_id: @group_performed_warmup.routine_id, status: @group_performed_warmup.status, warmup_id: @group_performed_warmup.warmup_id }
    end

    assert_redirected_to group_performed_warmup_path(assigns(:group_performed_warmup))
  end

  test "should show group_performed_warmup" do
    get :show, id: @group_performed_warmup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_performed_warmup
    assert_response :success
  end

  test "should update group_performed_warmup" do
    patch :update, id: @group_performed_warmup, group_performed_warmup: { routine_id: @group_performed_warmup.routine_id, status: @group_performed_warmup.status, warmup_id: @group_performed_warmup.warmup_id }
    assert_redirected_to group_performed_warmup_path(assigns(:group_performed_warmup))
  end

  test "should destroy group_performed_warmup" do
    assert_difference('GroupPerformedWarmup.count', -1) do
      delete :destroy, id: @group_performed_warmup
    end

    assert_redirected_to group_performed_warmups_path
  end
end
