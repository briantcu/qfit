json.inbox @inbox do |message|
  json.extract! message, :id, :poster_id, :message, :parent_id, :to_id, :message_type
  json.url message_url(message, format: :json)
end
json.outbox @outbox do |message|
  json.extract! message, :id, :poster_id, :message, :parent_id, :to_id, :message_type
  json.url message_url(message, format: :json)
end
