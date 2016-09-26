json.extract! @group_routine, :id, :group_id, :day_performed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id,
              :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved

json.performed_warm_ups @group_routine.group_performed_warmups, :id, :status, :warmup
json.performed_exercises @group_routine.group_performed_exercises, :id, :status, :exercise_type, :exercise
json.performed_plyometrics @group_routine.group_performed_plyos, :id, :status, :plyometric
json.performed_sprints @group_routine.group_performed_sprints, :id, :sprint_id, :status, :sprint, :sprint_details
json.custom_exercises @group_routine.group_custom_exercises, :id, :ex_type, :name, :details
