require 'rails_helper'

RSpec.describe SubscriptionService do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'activates an apple subscription' do
    allow(EmailService).to receive(:perform_async)
    allow(Venice::Receipt).to receive(:verify).and_return(Venice::Receipt.new({'expiration_date' => '1401924047883'}))

    response = SubscriptionService.instance.activate_subscription_for_apple(@user, 'dkdkdkd')
    expect(response[:status]).to eq('success')
  end
end