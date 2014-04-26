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
end
