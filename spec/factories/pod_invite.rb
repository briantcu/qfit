FactoryGirl.define do
  factory(:pod_invite) do
    sent_to 'email'
    status 2
  end
end
