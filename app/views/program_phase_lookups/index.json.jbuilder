json.array!(@program_phase_lookups) do |program_phase_lookup|
  json.extract! program_phase_lookup, :id, :phase_number, :program_type, :phase_id
  json.url program_phase_lookup_url(program_phase_lookup, format: :json)
end
