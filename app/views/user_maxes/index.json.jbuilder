json.array!(@user_maxes) do |user_max|
  json.extract! user_max, :id, :exercise_id, :user_id, :max
  json.url user_max_url(user_max, format: :json)
end
