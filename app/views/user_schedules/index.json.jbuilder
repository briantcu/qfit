json.array!(@user_schedules) do |user_schedule|
  json.extract! user_schedule, :id, :user_id, :program_id, :program_type, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start, :sign_up_date
end
