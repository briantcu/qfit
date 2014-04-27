require 'test_helper'

class ProgramTypesControllerTest < ActionController::TestCase
  setup do
    @program_type = program_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_type" do
    assert_difference('ProgramType.count') do
      post :create, program_type: { program_type: @program_type.program_type }
    end

    assert_redirected_to program_type_path(assigns(:program_type))
  end

  test "should show program_type" do
    get :show, id: @program_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_type
    assert_response :success
  end

  test "should update program_type" do
    patch :update, id: @program_type, program_type: { program_type: @program_type.program_type }
    assert_redirected_to program_type_path(assigns(:program_type))
  end

  test "should destroy program_type" do
    assert_difference('ProgramType.count', -1) do
      delete :destroy, id: @program_type
    end

    assert_redirected_to program_types_path
  end
end
