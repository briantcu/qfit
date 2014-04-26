json.array!(@performed_exercises) do |performed_exercise|
  json.extract! performed_exercise, :id, :routine_id, :exercise_id, :rest_period, :status, :one_rep_max, :group_performed_exercise_id, :exercise_type
  json.url performed_exercise_url(performed_exercise, format: :json)
end
