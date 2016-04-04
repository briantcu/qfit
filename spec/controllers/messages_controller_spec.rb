require 'rails_helper'

RSpec.describe MessagesController, type: :controller do

  it 'should send a dm to someone else' do
    user_one = FactoryGirl.create(:user)
    user_two = FactoryGirl.create(:user)

    sign_in user_one
    post :create, message: { message: "sup", to_id: user_two.id, message_type: 2 }, format: :json
    expect(user_one.outbox.count).to eq(1)
    expect(user_two.inbox.count).to eq(1)
  end

  it 'should return all messages' do
    user_one = FactoryGirl.create(:user)
    FactoryGirl.create(:message, poster: user_one)
    FactoryGirl.create(:message, receiver: user_one)
    get :index, format: :json
    body = JSON.parse(response.body)
    expect(body.count).to eq(2)
  end
end