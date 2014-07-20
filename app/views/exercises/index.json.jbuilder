json.array!(@exercise_types) do |type|
  json.extract! type, :type_name
  json.exercises type.exercises, :id, :exercise_type_id, :video_link, :look_up_value, :percent_of_luv, :category, :difficulty, :is_body_weight, :name, :is_image

end
