json.array!(@day_exercises) do |day_exercise|
  json.extract! day_exercise, :id, :program_day_id, :ex_type
  json.url day_exercise_url(day_exercise, format: :json)
end
