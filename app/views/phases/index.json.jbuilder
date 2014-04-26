json.array!(@phases) do |phase|
  json.extract! phase, :id, :male_power_sets, :male_power_reps, :male_other_sets, :male_other_reps, :fem_power_sets, :fem_power_reps, :fem_other_sets, :fem_other_reps
  json.url phase_url(phase, format: :json)
end
