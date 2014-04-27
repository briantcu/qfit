json.array!(@program_types) do |program_type|
  json.extract! program_type, :id, :program_type
  json.url program_type_url(program_type, format: :json)
end
