json.array!(@leaders) do |leader|
  json.extract! leader, :id, :user_id, :first_name, :last_name, :value, :type, :created
  json.url leader_url(leader, format: :json)
end
