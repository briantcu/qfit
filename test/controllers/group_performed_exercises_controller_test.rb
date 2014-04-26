require 'test_helper'

class GroupPerformedExercisesControllerTest < ActionController::TestCase
  setup do
    @group_performed_exercise = group_performed_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_performed_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_performed_exercise" do
    assert_difference('GroupPerformedExercise.count') do
      post :create, group_performed_exercise: { exercise_id: @group_performed_exercise.exercise_id, exercise_type: @group_performed_exercise.exercise_type, performed_exercise_id: @group_performed_exercise.performed_exercise_id, routine_id: @group_performed_exercise.routine_id, status: @group_performed_exercise.status }
    end

    assert_redirected_to group_performed_exercise_path(assigns(:group_performed_exercise))
  end

  test "should show group_performed_exercise" do
    get :show, id: @group_performed_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_performed_exercise
    assert_response :success
  end

  test "should update group_performed_exercise" do
    patch :update, id: @group_performed_exercise, group_performed_exercise: { exercise_id: @group_performed_exercise.exercise_id, exercise_type: @group_performed_exercise.exercise_type, performed_exercise_id: @group_performed_exercise.performed_exercise_id, routine_id: @group_performed_exercise.routine_id, status: @group_performed_exercise.status }
    assert_redirected_to group_performed_exercise_path(assigns(:group_performed_exercise))
  end

  test "should destroy group_performed_exercise" do
    assert_difference('GroupPerformedExercise.count', -1) do
      delete :destroy, id: @group_performed_exercise
    end

    assert_redirected_to group_performed_exercises_path
  end
end
