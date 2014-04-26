json.array!(@group_custom_exercises) do |group_custom_exercise|
  json.extract! group_custom_exercise, :id, :routine_id, :details, :status, :name, :type
  json.url group_custom_exercise_url(group_custom_exercise, format: :json)
end
