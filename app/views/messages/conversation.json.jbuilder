json.messages @messages do |message|
  json.extract! message, :id, :poster_id, :message, :to_id, :created_at
end
json.user do
  json.id @user.id
  json.user_name @user.user_name
  json.avatars @user.avatars
end