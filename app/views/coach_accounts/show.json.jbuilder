json.extract! @coach_account, :id, :num_accts, :billing_email
json.user @coach_account.user, :id, :first_name, :last_name
json.sign_up_codes @coach_account.user.sign_up_codes do |sign_up_code|
    json.extract! sign_up_code, :sent_to, :sent_to_type, :used, :created_at
end
json.num_used_accounts @coach_account.players.count
json.num_sent_codes @coach_account.user.sign_up_codes.unused.count
json.teams @coach_account.coach_groups.not_template do |group|
  json.extract! group, :id, :name
  json.players group.members do |user|
    json.id user.id
    json.first_name user.first_name
    json.last_name user.last_name
    json.flag_text user.flag_text_for_coach
    json.program_type_id user.program_type_id
  end
end
json.individuals @coach_account.players.without_group do |player|
  json.id player.id
  json.first_name player.first_name
  json.last_name player.last_name
  json.flag_text player.flag_text_for_coach
  json.program_type_id player.program_type_id
end
