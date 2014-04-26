require 'test_helper'

class GroupRoutinesControllerTest < ActionController::TestCase
  setup do
    @group_routine = group_routines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_routines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_routine" do
    assert_difference('GroupRoutine.count') do
      post :create, group_routine: { changes_saved: @group_routine.changes_saved, day_performed: @group_routine.day_performed, group_id: @group_routine.group_id, modified: @group_routine.modified, pl_day_id: @group_routine.pl_day_id, pl_modified: @group_routine.pl_modified, program_day_id: @group_routine.program_day_id, sp_day_id: @group_routine.sp_day_id, sp_modified: @group_routine.sp_modified, wt_day_id: @group_routine.wt_day_id, wt_modified: @group_routine.wt_modified, wu_day_id: @group_routine.wu_day_id, wu_modified: @group_routine.wu_modified }
    end

    assert_redirected_to group_routine_path(assigns(:group_routine))
  end

  test "should show group_routine" do
    get :show, id: @group_routine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_routine
    assert_response :success
  end

  test "should update group_routine" do
    patch :update, id: @group_routine, group_routine: { changes_saved: @group_routine.changes_saved, day_performed: @group_routine.day_performed, group_id: @group_routine.group_id, modified: @group_routine.modified, pl_day_id: @group_routine.pl_day_id, pl_modified: @group_routine.pl_modified, program_day_id: @group_routine.program_day_id, sp_day_id: @group_routine.sp_day_id, sp_modified: @group_routine.sp_modified, wt_day_id: @group_routine.wt_day_id, wt_modified: @group_routine.wt_modified, wu_day_id: @group_routine.wu_day_id, wu_modified: @group_routine.wu_modified }
    assert_redirected_to group_routine_path(assigns(:group_routine))
  end

  test "should destroy group_routine" do
    assert_difference('GroupRoutine.count', -1) do
      delete :destroy, id: @group_routine
    end

    assert_redirected_to group_routines_path
  end
end
