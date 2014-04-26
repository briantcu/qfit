json.array!(@coach_accounts) do |coach_account|
  json.extract! coach_account, :id, :user_id, :num_accts, :billing_email
  json.url coach_account_url(coach_account, format: :json)
end
