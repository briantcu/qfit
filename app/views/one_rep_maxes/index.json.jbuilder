json.array!(@one_rep_maxes) do |one_rep_max|
  json.extract! one_rep_max, :id, :rep, :percentage
  json.url one_rep_max_url(one_rep_max, format: :json)
end
