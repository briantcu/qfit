json.array!(@user_maxes) do |user_max|
  json.max user_max.max
  json.exercise_id user_max.exercise_id
  json.exercise user_max.exercise.try(:name)
end
