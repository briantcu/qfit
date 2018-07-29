require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it 'indicate that the email exists' do
    FactoryGirl.create(:user, email: 'my@email.com')
    post :email_exists, email: 'my@email.com'
    expect(response.status).to eq(204)
  end

  it 'indicate that the email does not exist' do
    post :email_exists, email: 'my@email.com'
    expect(response.status).to eq(404)
  end
end