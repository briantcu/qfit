json.array!(@friends) do |friend|
  json.extract! friend, :id, :power_index, :user_name
  json.avatar friend.avatar_path
end