json.array!(@group_performed_plyos) do |group_performed_plyo|
  json.extract! group_performed_plyo, :id, :plyometric_id, :routine_id, :status
  json.url group_performed_plyo_url(group_performed_plyo, format: :json)
end
