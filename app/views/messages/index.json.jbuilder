json.array!(@messages) do |message|
  json.extract! message, :id, :poster_id, :message, :parent_id, :to_id, :type
  json.url message_url(message, format: :json)
end
