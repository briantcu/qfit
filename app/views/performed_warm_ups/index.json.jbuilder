json.array!(@performed_warm_ups) do |performed_warm_up|
  json.extract! performed_warm_up, :id, :routine_id, :warmup_id, :status, :group_warmup_id, :completed
  json.url performed_warm_up_url(performed_warm_up, format: :json)
end
