require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, group: { coach_user_id: @group.coach_user_id, current_phase: @group.current_phase, last_pl_day_created: @group.last_pl_day_created, last_sp_day_created: @group.last_sp_day_created, last_weight_day_created: @group.last_weight_day_created, last_wu_day_created: @group.last_wu_day_created, name: @group.name, shared: @group.shared, sprint_diff: @group.sprint_diff }
    end

    assert_redirected_to group_path(assigns(:group))
  end

  test "should show group" do
    get :show, id: @group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group
    assert_response :success
  end

  test "should update group" do
    patch :update, id: @group, group: { coach_user_id: @group.coach_user_id, current_phase: @group.current_phase, last_pl_day_created: @group.last_pl_day_created, last_sp_day_created: @group.last_sp_day_created, last_weight_day_created: @group.last_weight_day_created, last_wu_day_created: @group.last_wu_day_created, name: @group.name, shared: @group.shared, sprint_diff: @group.sprint_diff }
    assert_redirected_to group_path(assigns(:group))
  end

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, id: @group
    end

    assert_redirected_to groups_path
  end
end
