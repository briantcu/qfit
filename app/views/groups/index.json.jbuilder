json.array!(@groups) do |group|
  json.extract! group, :id, :coach_user_id, :name, :current_phase, :sprint_diff, :last_weight_day_created, :last_wu_day_created, :last_pl_day_created, :last_sp_day_created, :shared
  json.url group_url(group, format: :json)
end
