require 'test_helper'

class SprintDetailSequencesControllerTest < ActionController::TestCase
  setup do
    @sprint_detail_sequence = sprint_detail_sequences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sprint_detail_sequences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sprint_detail_sequence" do
    assert_difference('SprintDetailSequence.count') do
      post :create, sprint_detail_sequence: { detail_num: @sprint_detail_sequence.detail_num, order_num: @sprint_detail_sequence.order_num, sprint_id: @sprint_detail_sequence.sprint_id }
    end

    assert_redirected_to sprint_detail_sequence_path(assigns(:sprint_detail_sequence))
  end

  test "should show sprint_detail_sequence" do
    get :show, id: @sprint_detail_sequence
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sprint_detail_sequence
    assert_response :success
  end

  test "should update sprint_detail_sequence" do
    patch :update, id: @sprint_detail_sequence, sprint_detail_sequence: { detail_num: @sprint_detail_sequence.detail_num, order_num: @sprint_detail_sequence.order_num, sprint_id: @sprint_detail_sequence.sprint_id }
    assert_redirected_to sprint_detail_sequence_path(assigns(:sprint_detail_sequence))
  end

  test "should destroy sprint_detail_sequence" do
    assert_difference('SprintDetailSequence.count', -1) do
      delete :destroy, id: @sprint_detail_sequence
    end

    assert_redirected_to sprint_detail_sequences_path
  end
end
