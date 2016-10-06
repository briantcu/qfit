json.array!(@pod_incoming) do |pod_invite|
  json.extract! pod_invite, :id, :inviter, :sent_to, :status, :invitee
end
json.array!(@pod_outgoing) do |pod_invite|
  json.extract! pod_invite, :id, :inviter, :sent_to, :status, :invitee
end
