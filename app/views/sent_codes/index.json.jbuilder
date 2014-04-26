json.array!(@sent_codes) do |sent_code|
  json.extract! sent_code, :id, :code, :receiver, :used
  json.url sent_code_url(sent_code, format: :json)
end
