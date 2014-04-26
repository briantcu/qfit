json.array!(@laps) do |lap|
  json.extract! lap, :id, :lap_number, :performed_sprint_id, :completed
  json.url lap_url(lap, format: :json)
end
