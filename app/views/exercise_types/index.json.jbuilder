json.array!(@exercise_types) do |exercise_type|
  json.extract! exercise_type, :id, :type_name
  json.exercises exercise_type.exercises.order(paid_tier: :asc, difficulty: :asc), :id, :video_link, :name, :paid_tier, :difficulty
end
