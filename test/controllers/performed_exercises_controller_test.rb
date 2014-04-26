require 'test_helper'

class PerformedExercisesControllerTest < ActionController::TestCase
  setup do
    @performed_exercise = performed_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performed_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performed_exercise" do
    assert_difference('PerformedExercise.count') do
      post :create, performed_exercise: { exercise_id: @performed_exercise.exercise_id, exercise_type: @performed_exercise.exercise_type, group_performed_exercise_id: @performed_exercise.group_performed_exercise_id, one_rep_max: @performed_exercise.one_rep_max, rest_period: @performed_exercise.rest_period, routine_id: @performed_exercise.routine_id, status: @performed_exercise.status }
    end

    assert_redirected_to performed_exercise_path(assigns(:performed_exercise))
  end

  test "should show performed_exercise" do
    get :show, id: @performed_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performed_exercise
    assert_response :success
  end

  test "should update performed_exercise" do
    patch :update, id: @performed_exercise, performed_exercise: { exercise_id: @performed_exercise.exercise_id, exercise_type: @performed_exercise.exercise_type, group_performed_exercise_id: @performed_exercise.group_performed_exercise_id, one_rep_max: @performed_exercise.one_rep_max, rest_period: @performed_exercise.rest_period, routine_id: @performed_exercise.routine_id, status: @performed_exercise.status }
    assert_redirected_to performed_exercise_path(assigns(:performed_exercise))
  end

  test "should destroy performed_exercise" do
    assert_difference('PerformedExercise.count', -1) do
      delete :destroy, id: @performed_exercise
    end

    assert_redirected_to performed_exercises_path
  end
end
