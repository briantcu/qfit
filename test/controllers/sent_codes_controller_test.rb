require 'test_helper'

class SentCodesControllerTest < ActionController::TestCase
  setup do
    @sent_code = sent_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sent_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sent_code" do
    assert_difference('SentCode.count') do
      post :create, sent_code: { code: @sent_code.code, receiver: @sent_code.receiver, used: @sent_code.used }
    end

    assert_redirected_to sent_code_path(assigns(:sent_code))
  end

  test "should show sent_code" do
    get :show, id: @sent_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sent_code
    assert_response :success
  end

  test "should update sent_code" do
    patch :update, id: @sent_code, sent_code: { code: @sent_code.code, receiver: @sent_code.receiver, used: @sent_code.used }
    assert_redirected_to sent_code_path(assigns(:sent_code))
  end

  test "should destroy sent_code" do
    assert_difference('SentCode.count', -1) do
      delete :destroy, id: @sent_code
    end

    assert_redirected_to sent_codes_path
  end
end
