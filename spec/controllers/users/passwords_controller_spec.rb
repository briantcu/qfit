require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do

  before(:each) do
    @passwords_controller = Users::PasswordsController.new
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'update' do
    it 'does not allow update if not logged in' do
      put :update
      expect(response.status).to eq(401)
    end

    it 'does not allow update if passwords dont match' do
      user = FactoryGirl.create(:user, password: 'password')
      sign_in user
      put :update, { user: { current_password: 'password', password: 'new_password', password_confirmation: 'nope' } }
      expect(response.status).to eq(404)
    end

    it 'allows password update' do
      user = FactoryGirl.create(:user, password: 'password')
      ep = user.encrypted_password
      sign_in user
      put :update, { user: { current_password: 'password', password: 'new_password', password_confirmation: 'new_password' } }
      expect(response.status).to eq(201)
      expect(user.reload.encrypted_password).not_to eq(ep)
    end
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