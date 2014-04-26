require 'test_helper'

class DayExercisesControllerTest < ActionController::TestCase
  setup do
    @day_exercise = day_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:day_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create day_exercise" do
    assert_difference('DayExercise.count') do
      post :create, day_exercise: { ex_type: @day_exercise.ex_type, program_day_id: @day_exercise.program_day_id }
    end

    assert_redirected_to day_exercise_path(assigns(:day_exercise))
  end

  test "should show day_exercise" do
    get :show, id: @day_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @day_exercise
    assert_response :success
  end

  test "should update day_exercise" do
    patch :update, id: @day_exercise, day_exercise: { ex_type: @day_exercise.ex_type, program_day_id: @day_exercise.program_day_id }
    assert_redirected_to day_exercise_path(assigns(:day_exercise))
  end

  test "should destroy day_exercise" do
    assert_difference('DayExercise.count', -1) do
      delete :destroy, id: @day_exercise
    end

    assert_redirected_to day_exercises_path
  end
end
