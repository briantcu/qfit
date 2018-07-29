FactoryGirl.define do
  factory(:workout_schedule_suggestion) do
    num_plyo_days 2
    num_sprint_days 2
    num_weight_days 0
    program_id 2
    program_type 1
    weight_schedule 0
  end
end
