json.extract! @user, :id, :first_name, :last_name, :email, :sex, :status,
              :power_index, :phone, :user_name, :weight, :program_type, :birth_year, :points, :paid_tier
if @user.user_schedule.present?
  json.user_schedule @user.user_schedule, :id, :program_id, :program_type_id, :phase_one_start, :phase_two_start,
                   :phase_three_start, :phase_three_start
end
json.avatar @user.avatar_path
json.coach_account_id @user.coach_account.try(:id)
json.num_accts @user.coach_account.try(:num_accts)
json.is_coach @user.is_coach?
json.is_sub_user @user.is_sub_user?
json.is_individual @user.is_individual?

