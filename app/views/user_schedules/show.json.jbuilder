json.extract! @user_schedule, :id, :user_id, :program_id, :program_type_id, :phase_one_start, :phase_two_start, :phase_three_start, :phase_four_start, :sign_up_date

json.weekly_schedule_days @user_schedule.weekly_schedule_days, :id, :day, :weights, :plyometrics, :stretching, :sprinting