json.array!(@group_schedule_days) do |group_schedule_day|
  json.extract! group_schedule_day, :id, :group_schedule_id, :weights, :plyos, :stretching, :sprinting
  json.url group_schedule_day_url(group_schedule_day, format: :json)
end
