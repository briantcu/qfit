json.array!(@performed_sprints) do |performed_sprint|
  json.extract! performed_sprint, :id, :sprint_id, :status, :group_performed_sprint_id, :routine_id
  json.url performed_sprint_url(performed_sprint, format: :json)
end
