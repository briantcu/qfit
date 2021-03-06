json.extract! @daily_routine, :id, :user_id, :group_id, :day_performed, :weight, :power_index, :count_ex_provided, :count_ex_completed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id, :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved, :closed, :shared, :group_routine_id, :updated_at

json.performed_warm_ups @daily_routine.performed_warm_ups, :id, :status, :completed, :warmup
json.performed_exercises @daily_routine.performed_exercises, :id, :status, :rest_period, :exercise_type, :weight_sets, :exercise
json.performed_plyometrics @daily_routine.performed_plyometrics, :id, :status, :performed_one, :performed_two, :performed_three, :plyometric
json.performed_sprints @daily_routine.performed_sprints, :id, :sprint_id, :status, :laps, :sprint, :sprint_details
json.custom_exercises @daily_routine.custom_exercises, :id, :ex_type, :name, :details, :status
json.messages @daily_routine.routine_messages
json.share_link @daily_routine.share_link

json.comments Message.includes(:poster).where(message_type: 5, to_id: @daily_routine.id) do |message|
  json.poster do
    json.id message.poster.id
    json.user_name message.poster.user_name
    json.avatar message.poster.avatar_path
  end
  json.id message.id
  json.created_at message.created_at
  json.parent_id message.parent_id
  json.message message.message
end
