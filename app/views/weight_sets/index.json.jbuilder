json.array!(@weight_sets) do |weight_set|
  json.extract! weight_set, :id, :set_num, :performed_exercise_id, :rec_weight, :rec_reps, :perf_weight, :perf_reps
  json.url weight_set_url(weight_set, format: :json)
end
