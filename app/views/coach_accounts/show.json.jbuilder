json.extract! @coach_account, :id, :num_accts, :billing_email, :created_at, :updated_at
json.user @coach_account.user, :id, :first_name, :last_name
json.array! @coach_account.coach_groups do |group|
  json.id group.id
  json.name group.name
  json.array! group.members do |user|
    json.id user.id
    json.first_name user.first_name
    json.last_name user.last_name
    json.flag_text player.flag_text_for_coach
  end
end
json.array! @coach_account.players do |player|
  json.id user.id
  json.first_name player.first_name
  json.last_name player.last_name
  json.flag_text player.flag_text_for_coach
end
json.sign_up_code @coach_account.user.sign_up_code, :code
json.sent_code @coach_account.user.sent_code, :receiver, :used