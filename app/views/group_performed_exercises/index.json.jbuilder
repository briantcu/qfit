json.array!(@group_performed_exercises) do |group_performed_exercise|
  json.extract! group_performed_exercise, :id, :performed_exercise_id, :routine_id, :exercise_id, :status, :exercise_type
  json.url group_performed_exercise_url(group_performed_exercise, format: :json)
end
