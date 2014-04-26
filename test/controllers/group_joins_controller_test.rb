require 'test_helper'

class GroupJoinsControllerTest < ActionController::TestCase
  setup do
    @group_join = group_joins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_joins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_join" do
    assert_difference('GroupJoin.count') do
      post :create, group_join: { group_id: @group_join.group_id, user_id: @group_join.user_id }
    end

    assert_redirected_to group_join_path(assigns(:group_join))
  end

  test "should show group_join" do
    get :show, id: @group_join
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_join
    assert_response :success
  end

  test "should update group_join" do
    patch :update, id: @group_join, group_join: { group_id: @group_join.group_id, user_id: @group_join.user_id }
    assert_redirected_to group_join_path(assigns(:group_join))
  end

  test "should destroy group_join" do
    assert_difference('GroupJoin.count', -1) do
      delete :destroy, id: @group_join
    end

    assert_redirected_to group_joins_path
  end
end
