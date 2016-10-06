json.array!(@performed_plyometrics) do |performed_plyometric|
  json.extract! performed_plyometric, :id, :plyometric_id, :routine_id, :status, :group_performed_plyometric_id, :performed_one, :performed_two, :performed_three
end
