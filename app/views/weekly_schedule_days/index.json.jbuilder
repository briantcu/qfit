json.array!(@weekly_schedule_days) do |weekly_schedule_day|
  json.extract! weekly_schedule_day, :id, :day, :user_schedule_id, :weights, :plyometrics, :stretching, :sprinting
  json.url weekly_schedule_day_url(weekly_schedule_day, format: :json)
end
