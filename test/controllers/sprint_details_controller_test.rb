require 'test_helper'

class SprintDetailsControllerTest < ActionController::TestCase
  setup do
    @sprint_detail = sprint_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sprint_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sprint_detail" do
    assert_difference('SprintDetail.count') do
      post :create, sprint_detail: { detail: @sprint_detail.detail }
    end

    assert_redirected_to sprint_detail_path(assigns(:sprint_detail))
  end

  test "should show sprint_detail" do
    get :show, id: @sprint_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sprint_detail
    assert_response :success
  end

  test "should update sprint_detail" do
    patch :update, id: @sprint_detail, sprint_detail: { detail: @sprint_detail.detail }
    assert_redirected_to sprint_detail_path(assigns(:sprint_detail))
  end

  test "should destroy sprint_detail" do
    assert_difference('SprintDetail.count', -1) do
      delete :destroy, id: @sprint_detail
    end

    assert_redirected_to sprint_details_path
  end
end
