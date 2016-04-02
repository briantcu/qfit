FactoryGirl.define do
  factory(:weekly_schedule_day) do
    day 0
    plyometrics true
    sprinting true
    stretching true
    user_schedule_id 1
    weights true
  end
end
