json.extract! @coach_account, :id, :user_id, :num_accts, :billing_email, :created_at, :updated_at
json.user @coach_account.user, :first_name, :last_name
json.array! @coach_account.groups do |group|
  json.id group.id
  json.name group.name
  json.array! group.users do |user|
    json.id user.id
    json.first_name user.first_name
    json.last_name user.last_name
  end
end
json.sign_up_code @coach_account.user.sign_up_code, :code
json.sent_code @coach_acFcount.user.sent_code, :receiver, :used