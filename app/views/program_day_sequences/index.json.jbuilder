json.array!(@program_day_sequences) do |program_day_sequence|
  json.extract! program_day_sequence, :id, :program_id, :number_of_days, :one, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ten
  json.url program_day_sequence_url(program_day_sequence, format: :json)
end
