json.array!(@sign_up_codes) do |sign_up_code|
  json.extract! sign_up_code, :id, :code, :user_id, :email
  json.url sign_up_code_url(sign_up_code, format: :json)
end
