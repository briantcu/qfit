class ChangeColumnNamesPodInvite < ActiveRecord::Migration
  change_table :pod_invites do |t|
    t.rename :inviter, :inviter_id
    t.rename :invitee, :invitee_id
  end
end
