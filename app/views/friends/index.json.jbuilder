json.array!(@friends) do |friend|
  json.extract! friend, :id, :id_one, :id_two
  json.url friend_url(friend, format: :json)
end
