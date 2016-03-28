json.male_power_index do
  json.array!(Leaders.male_power_index) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.female_power_index do
  json.array!(Leaders.female_power_index) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.male_power_index_ratio do
  json.array!(Leaders.male_power_index_ratio) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.female_power_index_ratio do
  json.array!(Leaders.female_power_index_ratio) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.sprints_performed do
  json.array!(Leaders.sprints_performed) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.plyos_performed do
  json.array!(Leaders.plyos_performed) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.sets_performed do
  json.array!(Leaders.sets_performed) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
json.reps_performed do
  json.array!(Leaders.reps_performed) do |leader|
    json.extract! leader, :user_id, :first_name, :last_name, :value, :type
  end
end
