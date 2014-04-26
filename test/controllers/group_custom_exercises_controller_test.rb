require 'test_helper'

class GroupCustomExercisesControllerTest < ActionController::TestCase
  setup do
    @group_custom_exercise = group_custom_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_custom_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_custom_exercise" do
    assert_difference('GroupCustomExercise.count') do
      post :create, group_custom_exercise: { details: @group_custom_exercise.details, name: @group_custom_exercise.name, routine_id: @group_custom_exercise.routine_id, status: @group_custom_exercise.status, type: @group_custom_exercise.type }
    end

    assert_redirected_to group_custom_exercise_path(assigns(:group_custom_exercise))
  end

  test "should show group_custom_exercise" do
    get :show, id: @group_custom_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_custom_exercise
    assert_response :success
  end

  test "should update group_custom_exercise" do
    patch :update, id: @group_custom_exercise, group_custom_exercise: { details: @group_custom_exercise.details, name: @group_custom_exercise.name, routine_id: @group_custom_exercise.routine_id, status: @group_custom_exercise.status, type: @group_custom_exercise.type }
    assert_redirected_to group_custom_exercise_path(assigns(:group_custom_exercise))
  end

  test "should destroy group_custom_exercise" do
    assert_difference('GroupCustomExercise.count', -1) do
      delete :destroy, id: @group_custom_exercise
    end

    assert_redirected_to group_custom_exercises_path
  end
end
