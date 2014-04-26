json.array!(@tips) do |tip|
  json.extract! tip, :id, :exercise_type, :tip, :exercise_id
  json.url tip_url(tip, format: :json)
end
