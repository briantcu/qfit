require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do

  before(:each) do
    @passwords_controller = Users::PasswordsController.new
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'forgot password' do
    it 'sends a forgot password email' do
      user = FactoryGirl.create(:user, email: 'brian@quadfit.com', password: 'password')
      post :forgot, {email: 'brian@quadfit.com'}
      expect(response.status).to eq(200)
      expect(user.reload.reset_password_token).not_to be(nil)
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'return 404 if the user  email cant be found' do
      post :forgot, { email: 'brian@quadfit.com'}
      expect(response.status).to eq(404)
    end
  end

end