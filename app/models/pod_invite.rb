class PodInvite < ActiveRecord::Base
  validates :sent_to, uniqueness: { scope: :inviter }

  belongs_to :inviter, class_name: 'User', foreign_key: :inviter_id
  belongs_to :invitee, class_name: 'User', foreign_key: :invitee_id
end
