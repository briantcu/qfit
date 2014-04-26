require 'test_helper'

class ExerciseTypesControllerTest < ActionController::TestCase
  setup do
    @exercise_type = exercise_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exercise_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exercise_type" do
    assert_difference('ExerciseType.count') do
      post :create, exercise_type: { type_name: @exercise_type.type_name }
    end

    assert_redirected_to exercise_type_path(assigns(:exercise_type))
  end

  test "should show exercise_type" do
    get :show, id: @exercise_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exercise_type
    assert_response :success
  end

  test "should update exercise_type" do
    patch :update, id: @exercise_type, exercise_type: { type_name: @exercise_type.type_name }
    assert_redirected_to exercise_type_path(assigns(:exercise_type))
  end

  test "should destroy exercise_type" do
    assert_difference('ExerciseType.count', -1) do
      delete :destroy, id: @exercise_type
    end

    assert_redirected_to exercise_types_path
  end
end
