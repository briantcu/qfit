# == Schema Information
#
# Table name: pod_invites
#
#  id         :integer          not null, primary key
#  inviter    :integer
#  sent_to    :string(255)
#  status     :integer
#  invitee    :integer
#  created_at :datetime
#  updated_at :datetime
#

class PodInvite < ActiveRecord::Base
  validates :sent_to, uniqueness: { scope: :inviter }

  belongs_to :inviter, class_name: 'User', foreign_key: :inviter_id
  belongs_to :invitee, class_name: 'User', foreign_key: :invitee_id
end
