json.array!(@group_schedules) do |group_schedule|
  json.extract! group_schedule, :id, :group_id, :program_id, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start
  json.url group_schedule_url(group_schedule, format: :json)
end
