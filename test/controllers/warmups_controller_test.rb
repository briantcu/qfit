require 'test_helper'

class WarmupsControllerTest < ActionController::TestCase
  setup do
    @warmup = warmups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:warmups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create warmup" do
    assert_difference('Warmup.count') do
      post :create, warmup: { is_stretch: @warmup.is_stretch, name: @warmup.name, video_link: @warmup.video_link }
    end

    assert_redirected_to warmup_path(assigns(:warmup))
  end

  test "should show warmup" do
    get :show, id: @warmup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @warmup
    assert_response :success
  end

  test "should update warmup" do
    patch :update, id: @warmup, warmup: { is_stretch: @warmup.is_stretch, name: @warmup.name, video_link: @warmup.video_link }
    assert_redirected_to warmup_path(assigns(:warmup))
  end

  test "should destroy warmup" do
    assert_difference('Warmup.count', -1) do
      delete :destroy, id: @warmup
    end

    assert_redirected_to warmups_path
  end
end
