require 'test_helper'

class GroupPerformedPlyosControllerTest < ActionController::TestCase
  setup do
    @group_performed_plyo = group_performed_plyos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_performed_plyos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_performed_plyo" do
    assert_difference('GroupPerformedPlyo.count') do
      post :create, group_performed_plyo: { plyometric_id: @group_performed_plyo.plyometric_id, routine_id: @group_performed_plyo.routine_id, status: @group_performed_plyo.status }
    end

    assert_redirected_to group_performed_plyo_path(assigns(:group_performed_plyo))
  end

  test "should show group_performed_plyo" do
    get :show, id: @group_performed_plyo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_performed_plyo
    assert_response :success
  end

  test "should update group_performed_plyo" do
    patch :update, id: @group_performed_plyo, group_performed_plyo: { plyometric_id: @group_performed_plyo.plyometric_id, routine_id: @group_performed_plyo.routine_id, status: @group_performed_plyo.status }
    assert_redirected_to group_performed_plyo_path(assigns(:group_performed_plyo))
  end

  test "should destroy group_performed_plyo" do
    assert_difference('GroupPerformedPlyo.count', -1) do
      delete :destroy, id: @group_performed_plyo
    end

    assert_redirected_to group_performed_plyos_path
  end
end
