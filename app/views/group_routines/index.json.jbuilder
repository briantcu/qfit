json.array!(@group_routines) do |group_routine|
  json.extract! group_routine, :id, :group_id, :day_performed, :program_day_id, :wt_day_id, :sp_day_id, :pl_day_id, :wu_day_id, :modified, :pl_modified, :wt_modified, :wu_modified, :sp_modified, :changes_saved
end
