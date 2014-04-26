json.array!(@custom_exercises) do |custom_exercise|
  json.extract! custom_exercise, :id, :rid, :details, :status, :gid, :name, :type
  json.url custom_exercise_url(custom_exercise, format: :json)
end
