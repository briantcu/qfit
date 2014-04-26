require 'test_helper'

class DailyRoutinesControllerTest < ActionController::TestCase
  setup do
    @daily_routine = daily_routines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_routines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_routine" do
    assert_difference('DailyRoutine.count') do
      post :create, daily_routine: { changes_saved: @daily_routine.changes_saved, closed: @daily_routine.closed, count_ex_completed: @daily_routine.count_ex_completed, count_ex_provided: @daily_routine.count_ex_provided, day_performed: @daily_routine.day_performed, group_id: @daily_routine.group_id, modified: @daily_routine.modified, pl_day_id: @daily_routine.pl_day_id, pl_modified: @daily_routine.pl_modified, power_index: @daily_routine.power_index, program_day_id: @daily_routine.program_day_id, sp_day_id: @daily_routine.sp_day_id, sp_modified: @daily_routine.sp_modified, user_id: @daily_routine.user_id, weight: @daily_routine.weight, wt_day_id: @daily_routine.wt_day_id, wt_modified: @daily_routine.wt_modified, wu_day_id: @daily_routine.wu_day_id, wu_modified: @daily_routine.wu_modified }
    end

    assert_redirected_to daily_routine_path(assigns(:daily_routine))
  end

  test "should show daily_routine" do
    get :show, id: @daily_routine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_routine
    assert_response :success
  end

  test "should update daily_routine" do
    patch :update, id: @daily_routine, daily_routine: { changes_saved: @daily_routine.changes_saved, closed: @daily_routine.closed, count_ex_completed: @daily_routine.count_ex_completed, count_ex_provided: @daily_routine.count_ex_provided, day_performed: @daily_routine.day_performed, group_id: @daily_routine.group_id, modified: @daily_routine.modified, pl_day_id: @daily_routine.pl_day_id, pl_modified: @daily_routine.pl_modified, power_index: @daily_routine.power_index, program_day_id: @daily_routine.program_day_id, sp_day_id: @daily_routine.sp_day_id, sp_modified: @daily_routine.sp_modified, user_id: @daily_routine.user_id, weight: @daily_routine.weight, wt_day_id: @daily_routine.wt_day_id, wt_modified: @daily_routine.wt_modified, wu_day_id: @daily_routine.wu_day_id, wu_modified: @daily_routine.wu_modified }
    assert_redirected_to daily_routine_path(assigns(:daily_routine))
  end

  test "should destroy daily_routine" do
    assert_difference('DailyRoutine.count', -1) do
      delete :destroy, id: @daily_routine
    end

    assert_redirected_to daily_routines_path
  end
end
