json.extract! @coach_account, :id, :num_accts, :billing_email
json.user @coach_account.user, :id, :first_name, :last_name
json.sign_up_codes do
  json.array!(@coach_account.user.sign_up_codes) do |sign_up_code|
    json.extract! sign_up_code, :sent_to, :sent_to_type, :used, :created_at
  end
end
json.used_accounts @coach_account.players.count
json.teams @coach_account.coach_groups do |group|
  json.extract! group, :id, :name
  json.players group.members do |user|
    json.id user.id
    json.first_name user.first_name
    json.last_name user.last_name
    json.flag_text user.flag_text_for_coach
  end
end
json.individuals @coach_account.players.without_group do |player|
  json.id player.id
  json.first_name player.first_name
  json.last_name player.last_name
  json.flag_text player.flag_text_for_coach
end
