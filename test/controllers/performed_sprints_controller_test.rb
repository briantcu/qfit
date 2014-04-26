require 'test_helper'

class PerformedSprintsControllerTest < ActionController::TestCase
  setup do
    @performed_sprint = performed_sprints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performed_sprints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performed_sprint" do
    assert_difference('PerformedSprint.count') do
      post :create, performed_sprint: { group_performed_sprint_id: @performed_sprint.group_performed_sprint_id, routine_id: @performed_sprint.routine_id, sprint_id: @performed_sprint.sprint_id, status: @performed_sprint.status }
    end

    assert_redirected_to performed_sprint_path(assigns(:performed_sprint))
  end

  test "should show performed_sprint" do
    get :show, id: @performed_sprint
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performed_sprint
    assert_response :success
  end

  test "should update performed_sprint" do
    patch :update, id: @performed_sprint, performed_sprint: { group_performed_sprint_id: @performed_sprint.group_performed_sprint_id, routine_id: @performed_sprint.routine_id, sprint_id: @performed_sprint.sprint_id, status: @performed_sprint.status }
    assert_redirected_to performed_sprint_path(assigns(:performed_sprint))
  end

  test "should destroy performed_sprint" do
    assert_difference('PerformedSprint.count', -1) do
      delete :destroy, id: @performed_sprint
    end

    assert_redirected_to performed_sprints_path
  end
end
