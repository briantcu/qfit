require 'test_helper'

class UserMaxesControllerTest < ActionController::TestCase
  setup do
    @user_max = user_maxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_maxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_max" do
    assert_difference('UserMax.count') do
      post :create, user_max: { exercise_id: @user_max.exercise_id, max: @user_max.max, user_id: @user_max.user_id }
    end

    assert_redirected_to user_max_path(assigns(:user_max))
  end

  test "should show user_max" do
    get :show, id: @user_max
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_max
    assert_response :success
  end

  test "should update user_max" do
    patch :update, id: @user_max, user_max: { exercise_id: @user_max.exercise_id, max: @user_max.max, user_id: @user_max.user_id }
    assert_redirected_to user_max_path(assigns(:user_max))
  end

  test "should destroy user_max" do
    assert_difference('UserMax.count', -1) do
      delete :destroy, id: @user_max
    end

    assert_redirected_to user_maxes_path
  end
end
