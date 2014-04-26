json.array!(@group_performed_warmups) do |group_performed_warmup|
  json.extract! group_performed_warmup, :id, :routine_id, :warmup_id, :status
  json.url group_performed_warmup_url(group_performed_warmup, format: :json)
end
