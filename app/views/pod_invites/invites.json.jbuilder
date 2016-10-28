json.array!(@invites) do |invite|
  json.id invite.id
  json.user_name invite.inviter.user_name
  json.avatar invite.inviter.avatar_path
end