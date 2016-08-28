json.successes @successes do |invite|
  json.extract! invite[:pod_invite], :id, :inviter_id, :sent_to, :status, :invitee_id
  json.message 'success'
end
json.failures @failures do |invite|
  json.extract! invite[:pod_invite], :id, :inviter_id, :sent_to, :status, :invitee_id
  json.message invite[:message]
end