json.array!(@program_days) do |program_day|
  json.extract! program_day, :id, :day_enumeration
  json.url program_day_url(program_day, format: :json)
end
