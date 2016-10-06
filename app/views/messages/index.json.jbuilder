json.inbox @inbox do |message|
  json.extract! message, :id, :message, :parent_id, :message_type, :created_at
  json.poster do
    json.username message.poster.user_name
    json.avatar message.poster.avatar_path
    json.id message.poster_id
  end
end
json.outbox @outbox do |message|
  json.extract! message, :id, :poster_id, :message, :parent_id, :to_id, :message_type
end
