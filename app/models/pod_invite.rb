# == Schema Information
#
# Table name: pod_invites
#
#  id         :integer          not null, primary key
#  inviter_id :integer
#  sent_to    :string(255)
#  status     :integer
#  invitee_id :integer
#  created_at :datetime
#  updated_at :datetime
#

# Status: 0-invited, 1 accepted, 2 denied
class PodInvite < ActiveRecord::Base
  validates :sent_to, uniqueness: { scope: :inviter }

  belongs_to :inviter, class_name: 'User', foreign_key: :inviter_id
  belongs_to :invitee, class_name: 'User', foreign_key: :invitee_id

  def self.invites_for_user(user)
    PodInvite.where(invitee: user, status: 0).order(created_at: :desc)
  end
end
