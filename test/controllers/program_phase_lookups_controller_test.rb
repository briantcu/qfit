require 'test_helper'

class ProgramPhaseLookupsControllerTest < ActionController::TestCase
  setup do
    @program_phase_lookup = program_phase_lookups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_phase_lookups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_phase_lookup" do
    assert_difference('ProgramPhaseLookup.count') do
      post :create, program_phase_lookup: { phase_id: @program_phase_lookup.phase_id, phase_number: @program_phase_lookup.phase_number, program_type: @program_phase_lookup.program_type }
    end

    assert_redirected_to program_phase_lookup_path(assigns(:program_phase_lookup))
  end

  test "should show program_phase_lookup" do
    get :show, id: @program_phase_lookup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_phase_lookup
    assert_response :success
  end

  test "should update program_phase_lookup" do
    patch :update, id: @program_phase_lookup, program_phase_lookup: { phase_id: @program_phase_lookup.phase_id, phase_number: @program_phase_lookup.phase_number, program_type: @program_phase_lookup.program_type }
    assert_redirected_to program_phase_lookup_path(assigns(:program_phase_lookup))
  end

  test "should destroy program_phase_lookup" do
    assert_difference('ProgramPhaseLookup.count', -1) do
      delete :destroy, id: @program_phase_lookup
    end

    assert_redirected_to program_phase_lookups_path
  end
end
