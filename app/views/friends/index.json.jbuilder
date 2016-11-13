json.array!(@friends) do |friend|
  json.extract! friend, :id, :first_name, :last_name, :power_index, :user_name
  json.unseen_count Message.conversation(current_user.id, friend.id).unseen_by(current_user.id).count
  json.avatar friend.avatar_path
end
