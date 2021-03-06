require 'rails_helper'

RSpec.describe CoachInviteService do

  before(:each) do
    @user = FactoryGirl.create(:user, level: 5)
    @coach_account = FactoryGirl.create(:coach_account, user: @user)
  end

  it 'sends an invite via email' do
    allow(EmailService).to receive(:perform_async)
    response = CoachInviteService.instance.send_invite('bri.reg@gmail.com', @coach_account, 'team', 3)
    expect(response[:status]).to eq('success')
    expect(SignUpCode.last.sent_to).to eq('bri.reg@gmail.com')
    expect(SignUpCode.last.code).to_not be(nil)
  end

  it 'sends an invite via text' do
    allow(TextMessageService).to receive(:perform_async)
    response = CoachInviteService.instance.send_invite('817 291-3409', @coach_account, 'team', 3)
    expect(response[:status]).to eq('success')
    expect(SignUpCode.last.sent_to).to eq('8172913409')
    expect(SignUpCode.last.code).to_not be(nil)
  end

  it 'does not resend an invite' do
    allow(EmailService).to receive(:perform_async)
    response = CoachInviteService.instance.send_invite('bri.reg@gmail.com', @coach_account, 'team', 3)
    expect(response[:status]).to eq('success')
    response = CoachInviteService.instance.send_invite('bri.reg@gmail.com', @coach_account, 'team', 3)
    expect(response[:status]).to eq('exists')
  end

  it 'does not invite an existing user' do
    FactoryGirl.create(:user, email: 'bri.reg@gmail.com')
    response = CoachInviteService.instance.send_invite('bri.reg@gmail.com', @coach_account, 'team', 3)
    expect(response[:status]).to eq('invalid')
  end
end