json.array!(@sprints) do |sprint|
  json.extract! sprint, :id, :difficulty, :name, :sprint_type, :num_laps
  json.url sprint_url(sprint, format: :json)
end
