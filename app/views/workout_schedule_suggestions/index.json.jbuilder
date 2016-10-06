json.array!(@workout_schedule_suggestions) do |workout_schedule_suggestion|
  json.extract! workout_schedule_suggestion, :id, :program_type, :weight_schedule, :program_id, :num_weight_days, :num_plyo_days, :num_sprint_days
end
