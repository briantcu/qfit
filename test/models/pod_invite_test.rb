require 'test_helper'

class PodInviteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

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
