json.array!(@pod_incoming) do |pod_invite|
  json.extract! pod_invite, :id, :inviter, :sent_to, :status, :invitee
  json.url pod_invite_url(pod_invite, format: :json)
end
json.array!(@pod_outgoing) do |pod_invite|
  json.extract! pod_invite, :id, :inviter, :sent_to, :status, :invitee
  json.url pod_invite_url(pod_invite, format: :json)
end
