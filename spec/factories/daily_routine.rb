FactoryGirl.define do
  factory(:daily_routine) do
    changes_saved false
    closed false
    count_ex_completed nil
    count_ex_provided nil
    day_performed "2016-03-27"
    group_id 0
    group_routine_id 0
    modified false
    pl_day_id 1
    pl_modified false
    power_index nil
    program_day_id 3
    shared false
    sp_day_id 1
    sp_modified false
    user_id 1
    weight nil
    wt_day_id 1
    wt_modified false
    wu_day_id 1
    wu_modified false
  end
end
