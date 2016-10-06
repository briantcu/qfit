json.array!(@daily_routines) do |daily_routine|
  json.extract! daily_routine, :id, :day_performed
end
