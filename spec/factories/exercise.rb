FactoryGirl.define do
  factory(:exercise) do
    category 1
    difficulty nil
    exercise_type_id 1
    is_body_weight false
    is_image false
    look_up_value 1
    name "Clean Pull"
    paid_tier 1
    percent_of_luv 0.65
    video_link "83347318"
  end
end
