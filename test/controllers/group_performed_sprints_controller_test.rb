require 'test_helper'

class GroupPerformedSprintsControllerTest < ActionController::TestCase
  setup do
    @group_performed_sprint = group_performed_sprints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_performed_sprints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_performed_sprint" do
    assert_difference('GroupPerformedSprint.count') do
      post :create, group_performed_sprint: { routine_id: @group_performed_sprint.routine_id, sprint_id: @group_performed_sprint.sprint_id, status: @group_performed_sprint.status }
    end

    assert_redirected_to group_performed_sprint_path(assigns(:group_performed_sprint))
  end

  test "should show group_performed_sprint" do
    get :show, id: @group_performed_sprint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_performed_sprint
    assert_response :success
  end

  test "should update group_performed_sprint" do
    patch :update, id: @group_performed_sprint, group_performed_sprint: { routine_id: @group_performed_sprint.routine_id, sprint_id: @group_performed_sprint.sprint_id, status: @group_performed_sprint.status }
    assert_redirected_to group_performed_sprint_path(assigns(:group_performed_sprint))
  end

  test "should destroy group_performed_sprint" do
    assert_difference('GroupPerformedSprint.count', -1) do
      delete :destroy, id: @group_performed_sprint
    end

    assert_redirected_to group_performed_sprints_path
  end
end
