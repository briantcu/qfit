json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :type, :video_link, :look_up_value, :percent_of_luv, :category, :difficulty, :is_body_weight, :name, :is_image
  json.url exercise_url(exercise, format: :json)
end
