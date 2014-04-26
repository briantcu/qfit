json.array!(@group_performed_sprints) do |group_performed_sprint|
  json.extract! group_performed_sprint, :id, :sprint_id, :status, :routine_id
  json.url group_performed_sprint_url(group_performed_sprint, format: :json)
end
