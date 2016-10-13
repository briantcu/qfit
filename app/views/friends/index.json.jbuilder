json.array!(@friends) do |friend|
  json.extract! friend, :id, :first_name, :last_name, :power_index, :user_name
  json.avatar friend.avatar_path
end
