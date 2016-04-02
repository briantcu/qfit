FactoryGirl.define do
  factory(:user_schedule) do
    phase_four_start "2016-05-28"
    phase_one_start "2016-03-26"
    phase_three_start "2016-05-07"
    phase_two_start "2016-04-16"
    program_id 2
    program_type_id 3
    sign_up_date "2016-03-26"
    user_id 12
  end
end
