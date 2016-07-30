json.extract! @user, :id, :master_user_id, :first_name, :last_name, :email, :sex, :administrator, :sub_user,
              :knee_dom_max, :hor_push_max, :hor_pull_max, :power_index, :password, :current_phase, :phone,
              :last_weight_day_created, :last_warmup_day_created, :last_plyometric_day_created,
              :last_sprint_day_created, :user_name, :sprint_diff, :weight, :level, :program_type, :birth_year,
              :subscription_date, :created_at, :updated_at, :points
if @user.user_schedule.present?
  json.user_schedule @user.user_schedule, :id, :program_id, :program_type_id, :phase_one_start, :phase_two_start,
                   :phase_three_start, :phase_three_start
end
json.coach_account_id @user.coach_account.try(:id)

