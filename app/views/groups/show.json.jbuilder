json.extract! @group, :id, :coach_user_id, :name, :current_phase, :sprint_diff, :last_weight_day_created, :last_wu_day_created, :last_pl_day_created, :last_sp_day_created, :shared, :created_at, :updated_at
if @group.group_schedule.present?
  json.group_schedule @group.group_schedule, :id, :program_id, :phase_one_start, :phase_two_start,
                     :phase_three_start, :phase_three_start
end