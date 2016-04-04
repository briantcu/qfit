require 'rails_helper'

RSpec.describe PodInvitesController, type: :controller do

  it 'should send a new invite' do
    user_one = FactoryGirl.create(:user)
    user_two = FactoryGirl.create(:user)

    sign_in user_one
    post :create, message: { message: "sup", to_id: user_two.id, message_type: 2 }, format: :json
    expect(user_one.outbox.count).to eq(1)
    expect(user_two.inbox.count).to eq(1)
  end

end