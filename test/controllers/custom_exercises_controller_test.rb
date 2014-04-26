require 'test_helper'

class CustomExercisesControllerTest < ActionController::TestCase
  setup do
    @custom_exercise = custom_exercises(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:custom_exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create custom_exercise" do
    assert_difference('CustomExercise.count') do
      post :create, custom_exercise: { details: @custom_exercise.details, gid: @custom_exercise.gid, name: @custom_exercise.name, rid: @custom_exercise.rid, status: @custom_exercise.status, type: @custom_exercise.type }
    end

    assert_redirected_to custom_exercise_path(assigns(:custom_exercise))
  end

  test "should show custom_exercise" do
    get :show, id: @custom_exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @custom_exercise
    assert_response :success
  end

  test "should update custom_exercise" do
    patch :update, id: @custom_exercise, custom_exercise: { details: @custom_exercise.details, gid: @custom_exercise.gid, name: @custom_exercise.name, rid: @custom_exercise.rid, status: @custom_exercise.status, type: @custom_exercise.type }
    assert_redirected_to custom_exercise_path(assigns(:custom_exercise))
  end

  test "should destroy custom_exercise" do
    assert_difference('CustomExercise.count', -1) do
      delete :destroy, id: @custom_exercise
    end

    assert_redirected_to custom_exercises_path
  end
end
