require 'test_helper'

class PerformedPlyometricsControllerTest < ActionController::TestCase
  setup do
    @performed_plyometric = performed_plyometrics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performed_plyometrics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performed_plyometric" do
    assert_difference('PerformedPlyometric.count') do
      post :create, performed_plyometric: { group_performed_plyometric_id: @performed_plyometric.group_performed_plyometric_id, performed_one: @performed_plyometric.performed_one, performed_three: @performed_plyometric.performed_three, performed_two: @performed_plyometric.performed_two, plyometric_id: @performed_plyometric.plyometric_id, routine_id: @performed_plyometric.routine_id, status: @performed_plyometric.status }
    end

    assert_redirected_to performed_plyometric_path(assigns(:performed_plyometric))
  end

  test "should show performed_plyometric" do
    get :show, id: @performed_plyometric
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @performed_plyometric
    assert_response :success
  end

  test "should update performed_plyometric" do
    patch :update, id: @performed_plyometric, performed_plyometric: { group_performed_plyometric_id: @performed_plyometric.group_performed_plyometric_id, performed_one: @performed_plyometric.performed_one, performed_three: @performed_plyometric.performed_three, performed_two: @performed_plyometric.performed_two, plyometric_id: @performed_plyometric.plyometric_id, routine_id: @performed_plyometric.routine_id, status: @performed_plyometric.status }
    assert_redirected_to performed_plyometric_path(assigns(:performed_plyometric))
  end

  test "should destroy performed_plyometric" do
    assert_difference('PerformedPlyometric.count', -1) do
      delete :destroy, id: @performed_plyometric
    end

    assert_redirected_to performed_plyometrics_path
  end
end
