require 'test_helper'

class ProgramDaysControllerTest < ActionController::TestCase
  setup do
    @program_day = program_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_day" do
    assert_difference('ProgramDay.count') do
      post :create, program_day: { day_enumeration: @program_day.day_enumeration }
    end

    assert_redirected_to program_day_path(assigns(:program_day))
  end

  test "should show program_day" do
    get :show, id: @program_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_day
    assert_response :success
  end

  test "should update program_day" do
    patch :update, id: @program_day, program_day: { day_enumeration: @program_day.day_enumeration }
    assert_redirected_to program_day_path(assigns(:program_day))
  end

  test "should destroy program_day" do
    assert_difference('ProgramDay.count', -1) do
      delete :destroy, id: @program_day
    end

    assert_redirected_to program_days_path
  end
end
