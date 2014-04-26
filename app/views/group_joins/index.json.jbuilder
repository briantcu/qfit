json.array!(@group_joins) do |group_join|
  json.extract! group_join, :id, :group_id, :user_id
  json.url group_join_url(group_join, format: :json)
end
