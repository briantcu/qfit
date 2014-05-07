json.extract! @daily_routine, :id, :user_id, :group_id, :day_performed, :weight, :power_index, :count_ex_provided,
              :count_ex_completed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id, :wu_day_id, :modified,
              :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved, :closed

json.performed_warmups @daily_routine.performed_warm_ups, :id, :status, :completed
json.performed_exercises @daily_routine.performed_exercises, :id, :status, :rest_period, :exercise_type, :weight_sets
json.performed_plyometrics @daily_routine.performed_plyometrics, :id, :status, :performed_one, :performed_two, :performed_three
json.performed_sprints @daily_routine.performed_sprints, :id, :sprint_id, :status, :laps
json.custom_exercises @daily_routine.custom_exercises, :id, :type, :name, :details

json.comments Message.where(:type => 5, :to_id => @daily_routine.id)