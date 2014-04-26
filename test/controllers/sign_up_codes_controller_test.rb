require 'test_helper'

class SignUpCodesControllerTest < ActionController::TestCase
  setup do
    @sign_up_code = sign_up_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sign_up_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sign_up_code" do
    assert_difference('SignUpCode.count') do
      post :create, sign_up_code: { code: @sign_up_code.code, email: @sign_up_code.email, user_id: @sign_up_code.user_id }
    end

    assert_redirected_to sign_up_code_path(assigns(:sign_up_code))
  end

  test "should show sign_up_code" do
    get :show, id: @sign_up_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sign_up_code
    assert_response :success
  end

  test "should update sign_up_code" do
    patch :update, id: @sign_up_code, sign_up_code: { code: @sign_up_code.code, email: @sign_up_code.email, user_id: @sign_up_code.user_id }
    assert_redirected_to sign_up_code_path(assigns(:sign_up_code))
  end

  test "should destroy sign_up_code" do
    assert_difference('SignUpCode.count', -1) do
      delete :destroy, id: @sign_up_code
    end

    assert_redirected_to sign_up_codes_path
  end
end
