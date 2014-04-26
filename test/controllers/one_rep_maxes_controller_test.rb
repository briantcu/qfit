require 'test_helper'

class OneRepMaxesControllerTest < ActionController::TestCase
  setup do
    @one_rep_max = one_rep_maxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:one_rep_maxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create one_rep_max" do
    assert_difference('OneRepMax.count') do
      post :create, one_rep_max: { percentage: @one_rep_max.percentage, rep: @one_rep_max.rep }
    end

    assert_redirected_to one_rep_max_path(assigns(:one_rep_max))
  end

  test "should show one_rep_max" do
    get :show, id: @one_rep_max
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @one_rep_max
    assert_response :success
  end

  test "should update one_rep_max" do
    patch :update, id: @one_rep_max, one_rep_max: { percentage: @one_rep_max.percentage, rep: @one_rep_max.rep }
    assert_redirected_to one_rep_max_path(assigns(:one_rep_max))
  end

  test "should destroy one_rep_max" do
    assert_difference('OneRepMax.count', -1) do
      delete :destroy, id: @one_rep_max
    end

    assert_redirected_to one_rep_maxes_path
  end
end
