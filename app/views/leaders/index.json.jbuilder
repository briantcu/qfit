json.male_power_index do
  json.array!(Leader.male_power_index) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.female_power_index do
  json.array!(Leader.female_power_index) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.male_power_index_ratio do
  json.array!(Leader.male_power_index_ratio) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.female_power_index_ratio do
  json.array!(Leader.female_power_index_ratio) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.sprints_performed do
  json.array!(Leader.sprints_performed) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.plyos_performed do
  json.array!(Leader.plyos_performed) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.sets_performed do
  json.array!(Leader.sets_performed) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
json.reps_performed do
  json.array!(Leader.reps_performed) do |leader|
    json.leader do
      json.user_id leader.user_id
      json.value leader.value
      json.avatar leader.user.avatar_path
      json.user_name leader.user.user_name
    end
  end
end
