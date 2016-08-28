json.messages @messages do |message|
  json.extract! message, :id, :poster_id, :message, :to_id, :created_at
end
json.user json.extract! @user, :id, :user_name, :avatars