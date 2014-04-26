require 'test_helper'

class PlyometricsControllerTest < ActionController::TestCase
  setup do
    @plyometric = plyometrics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plyometrics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plyometric" do
    assert_difference('Plyometric.count') do
      post :create, plyometric: { name: @plyometric.name, recommended: @plyometric.recommended, video_link: @plyometric.video_link }
    end

    assert_redirected_to plyometric_path(assigns(:plyometric))
  end

  test "should show plyometric" do
    get :show, id: @plyometric
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plyometric
    assert_response :success
  end

  test "should update plyometric" do
    patch :update, id: @plyometric, plyometric: { name: @plyometric.name, recommended: @plyometric.recommended, video_link: @plyometric.video_link }
    assert_redirected_to plyometric_path(assigns(:plyometric))
  end

  test "should destroy plyometric" do
    assert_difference('Plyometric.count', -1) do
      delete :destroy, id: @plyometric
    end

    assert_redirected_to plyometrics_path
  end
end
