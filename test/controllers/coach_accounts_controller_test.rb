require 'test_helper'

class CoachAccountsControllerTest < ActionController::TestCase
  setup do
    @coach_account = coach_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coach_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coach_account" do
    assert_difference('CoachAccount.count') do
      post :create, coach_account: { billing_email: @coach_account.billing_email, num_accts: @coach_account.num_accts, user_id: @coach_account.user_id }
    end

    assert_redirected_to coach_account_path(assigns(:coach_account))
  end

  test "should show coach_account" do
    get :show, id: @coach_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coach_account
    assert_response :success
  end

  test "should update coach_account" do
    patch :update, id: @coach_account, coach_account: { billing_email: @coach_account.billing_email, num_accts: @coach_account.num_accts, user_id: @coach_account.user_id }
    assert_redirected_to coach_account_path(assigns(:coach_account))
  end

  test "should destroy coach_account" do
    assert_difference('CoachAccount.count', -1) do
      delete :destroy, id: @coach_account
    end

    assert_redirected_to coach_accounts_path
  end
end
