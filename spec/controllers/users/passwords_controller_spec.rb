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
  end

end