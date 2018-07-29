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

require 'rails_helper'

RSpec.describe PodInvitesController, type: :controller do

  it 'should send a new invite' do
    user_one = FactoryGirl.create(:user)
    allow_any_instance_of(QuadPodService).to receive(:send_invite).and_return({status: 'success', pod_invite: FactoryGirl.create(:pod_invite)})
    sign_in user_one
    post :create, pod_invite: {sent_to: ['bri.reg@gmail.com', '817291-3409']}, format: :json
    body = JSON.parse(response.body)
    expect(body['successes'].count).to eq(2)
  end

end
