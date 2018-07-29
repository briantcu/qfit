FactoryGirl.define do
  factory(:sign_up_code) do
    code "this code"
    sign_up_type 'team'
    sent_to 'email@email.com'
    sent_to_type 'email'
    group_id 4
  end
end