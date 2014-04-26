require 'test_helper'

class PhasesControllerTest < ActionController::TestCase
  setup do
    @phase = phases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:phases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create phase" do
    assert_difference('Phase.count') do
      post :create, phase: { fem_other_reps: @phase.fem_other_reps, fem_other_sets: @phase.fem_other_sets, fem_power_reps: @phase.fem_power_reps, fem_power_sets: @phase.fem_power_sets, male_other_reps: @phase.male_other_reps, male_other_sets: @phase.male_other_sets, male_power_reps: @phase.male_power_reps, male_power_sets: @phase.male_power_sets }
    end

    assert_redirected_to phase_path(assigns(:phase))
  end

  test "should show phase" do
    get :show, id: @phase
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @phase
    assert_response :success
  end

  test "should update phase" do
    patch :update, id: @phase, phase: { fem_other_reps: @phase.fem_other_reps, fem_other_sets: @phase.fem_other_sets, fem_power_reps: @phase.fem_power_reps, fem_power_sets: @phase.fem_power_sets, male_other_reps: @phase.male_other_reps, male_other_sets: @phase.male_other_sets, male_power_reps: @phase.male_power_reps, male_power_sets: @phase.male_power_sets }
    assert_redirected_to phase_path(assigns(:phase))
  end

  test "should destroy phase" do
    assert_difference('Phase.count', -1) do
      delete :destroy, id: @phase
    end

    assert_redirected_to phases_path
  end
end
