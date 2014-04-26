require 'test_helper'

class ProgramDaySequencesControllerTest < ActionController::TestCase
  setup do
    @program_day_sequence = program_day_sequences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:program_day_sequences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create program_day_sequence" do
    assert_difference('ProgramDaySequence.count') do
      post :create, program_day_sequence: { eight: @program_day_sequence.eight, five: @program_day_sequence.five, four: @program_day_sequence.four, nine: @program_day_sequence.nine, number_of_days: @program_day_sequence.number_of_days, one: @program_day_sequence.one, program_id: @program_day_sequence.program_id, seven: @program_day_sequence.seven, six: @program_day_sequence.six, ten: @program_day_sequence.ten, three: @program_day_sequence.three, two: @program_day_sequence.two }
    end

    assert_redirected_to program_day_sequence_path(assigns(:program_day_sequence))
  end

  test "should show program_day_sequence" do
    get :show, id: @program_day_sequence
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @program_day_sequence
    assert_response :success
  end

  test "should update program_day_sequence" do
    patch :update, id: @program_day_sequence, program_day_sequence: { eight: @program_day_sequence.eight, five: @program_day_sequence.five, four: @program_day_sequence.four, nine: @program_day_sequence.nine, number_of_days: @program_day_sequence.number_of_days, one: @program_day_sequence.one, program_id: @program_day_sequence.program_id, seven: @program_day_sequence.seven, six: @program_day_sequence.six, ten: @program_day_sequence.ten, three: @program_day_sequence.three, two: @program_day_sequence.two }
    assert_redirected_to program_day_sequence_path(assigns(:program_day_sequence))
  end

  test "should destroy program_day_sequence" do
    assert_difference('ProgramDaySequence.count', -1) do
      delete :destroy, id: @program_day_sequence
    end

    assert_redirected_to program_day_sequences_path
  end
end
