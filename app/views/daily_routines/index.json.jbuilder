json.array!(@daily_routines) do |daily_routine|
  json.extract! daily_routine, :id, :user_id, :group_id, :day_performed, :weight, :power_index, :count_ex_provided, :count_ex_completed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id, :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved, :closed
  json.url daily_routine_url(daily_routine, format: :json)
end