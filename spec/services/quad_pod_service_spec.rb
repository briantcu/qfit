require 'rails_helper'

RSpec.describe QuadPodService do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'sends an invite via email' do
    allow(EmailService).to receive(:perform_async)
    pi = PodInvite.create(inviter_id: @user.id, sent_to: 'bri.reg@gmail.com')
    response = QuadPodService.instance.send_invite(pi)
    expect(response[:status]).to eq('success')
  end

  it 'sends an invite via text' do
    allow(TextMessageService).to receive(:perform_async)
    pi = PodInvite.create(inviter_id: @user.id, sent_to: 'bri.reg@gmail.com')
    response = QuadPodService.instance.send_invite(pi)
    expect(response[:status]).to eq('success')
  end

  it 'accepts an invite for a new user' do
    pi = PodInvite.create(inviter_id: @user.id, sent_to: 'bri.reg@gmail.com')
    other = FactoryGirl.create(:user)
    token = QuadPodService.instance.send(:create_token, pi)
    QuadPodService.instance.accept_invite_new_user(token, other)
    expect(pi.reload.status).to eq(1)
    expect(other.reload.friends.map(&:id).include?(@user.id)).to be(true)
  end

  it 'denies a request' do
    other = FactoryGirl.create(:user)
    pi = PodInvite.create(inviter: @user, invitee: other, sent_to: other.email)
    QuadPodService.instance.deny_invite(pi)
    expect(pi.reload.status).to eq(2)
    expect(other.reload.friends.map(&:id).include?(@user.id)).to be(false)
  end

  it 'accepts an invite for an existing user' do
    other = FactoryGirl.create(:user)
    pi = PodInvite.create(inviter: @user, invitee: other, sent_to: other.email)
    QuadPodService.instance.accept_invite_existing_user(pi)
    expect(pi.reload.status).to eq(1)
    expect(other.reload.friends.map(&:id).include?(@user.id)).to be(true)
  end

  it 'does not resend a request' do
    other = FactoryGirl.create(:user)
    PodInvite.create(inviter: @user, invitee: other, sent_to: other.email)
    pi = PodInvite.new(inviter: @user, invitee: other, sent_to: other.email)
    response = QuadPodService.instance.send_invite(pi)
    expect(response[:status]).to eq('exists')
  end
end