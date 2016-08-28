json.array!(@friends) do |friend|
  json.extract! friend, :id, :first_name, :last_name, :power_index, :user_name, :avatars
  json.url friend_url(friend, format: :json)
end
