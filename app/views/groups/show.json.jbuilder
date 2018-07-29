json.extract! @group, :id, :coach_user_id, :name, :shared, :is_template
if @group.group_schedule.present?
  json.group_schedule @group.group_schedule, :id, :program_id, :phase_one_start, :phase_two_start,
                     :phase_three_start, :phase_three_start
end