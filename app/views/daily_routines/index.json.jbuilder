json.array!(@daily_routines) do |daily_routine|
  json.extract! daily_routine, :id, :day_performed
  json.url daily_routine_url(daily_routine, format: :json)
end
