json.extract! @user, :id, :first_name, :last_name, :email, :sex,
              :power_index, :phone, :user_name, :weight, :program_type, :birth_year, :points, :paid_tier
if @user.user_schedule.present?
  json.user_schedule @user.user_schedule, :id, :program_id, :program_type_id, :phase_one_start, :phase_two_start,
                   :phase_three_start, :phase_three_start
end
json.avatar @user.avatar_path
json.coach_account_id @user.coach_account.try(:id)

