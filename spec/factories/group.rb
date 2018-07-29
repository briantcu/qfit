FactoryGirl.define do
  factory(:group) do
    coach_user_id 4
    name "Name"
    current_phase 1
    sprint_diff 1
    last_weight_day_created 1
    last_wu_day_created 1
    last_pl_day_created 1
    last_sp_day_created 1
    shared false
  end
end