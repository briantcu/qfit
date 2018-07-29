json.array!(@performed_sprints) do |performed_sprint|
  json.extract! performed_sprint, :id, :sprint_id, :status, :group_performed_sprint_id, :routine_id
end
