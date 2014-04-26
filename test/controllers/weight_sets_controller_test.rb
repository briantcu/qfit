require 'test_helper'

class WeightSetsControllerTest < ActionController::TestCase
  setup do
    @weight_set = weight_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weight_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weight_set" do
    assert_difference('WeightSet.count') do
      post :create, weight_set: { perf_reps: @weight_set.perf_reps, perf_weight: @weight_set.perf_weight, performed_exercise_id: @weight_set.performed_exercise_id, rec_reps: @weight_set.rec_reps, rec_weight: @weight_set.rec_weight, set_num: @weight_set.set_num }
    end

    assert_redirected_to weight_set_path(assigns(:weight_set))
  end

  test "should show weight_set" do
    get :show, id: @weight_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weight_set
    assert_response :success
  end

  test "should update weight_set" do
    patch :update, id: @weight_set, weight_set: { perf_reps: @weight_set.perf_reps, perf_weight: @weight_set.perf_weight, performed_exercise_id: @weight_set.performed_exercise_id, rec_reps: @weight_set.rec_reps, rec_weight: @weight_set.rec_weight, set_num: @weight_set.set_num }
    assert_redirected_to weight_set_path(assigns(:weight_set))
  end

  test "should destroy weight_set" do
    assert_difference('WeightSet.count', -1) do
      delete :destroy, id: @weight_set
    end

    assert_redirected_to weight_sets_path
  end
end
