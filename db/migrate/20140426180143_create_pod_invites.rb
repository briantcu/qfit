class CreatePodInvites < ActiveRecord::Migration
  def change
    create_table :pod_invites do |t|
      t.integer :inviter
      t.string :sent_to
      t.integer :status
      t.integer :invitee

      t.timestamps
    end
  end
end
