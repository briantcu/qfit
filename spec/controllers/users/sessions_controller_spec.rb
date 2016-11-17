require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before(:each) do
    @passwords_controller = Users::PasswordsController.new
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  context 'sign in' do
    it 'throws 401 if the user cant be found' do
      post :create, { email: 'brian@quadfit.com', password: 'password'}
      expect(response.status).to eq(401)
    end

    it 'throws 401 if login is invalid' do
      user = FactoryGirl.create(:user, email: 'brian@quadfit.com', password: 'password')
      post :create, { email: 'brian@quadfit.com', password: 'nope'}
      expect(response.status).to eq(401)
    end

    it 'returns auth token and user id if success' do
      user = FactoryGirl.create(:user, email: 'brian@quadfit.com', password: 'password', id: 100)
      post :create, { email: 'brian@quadfit.com', password: 'password'}
      body = JSON.parse(response.body)
      expect(body['token']).not_to eq(nil)
      expect(body['user_id']).to eq(100)
    end

    it 'calls to create a workout if you need one' do
      allow_any_instance_of(RoutineService).to receive(:create_routines)
      FactoryGirl.create(:user, email: 'brian@quadfit.com', password: 'password', id: 100)
      post :create, { email: 'brian@quadfit.com', password: 'password'}
    end

    it 'does not call to create a workout if you need one' do
      expect_any_instance_of(RoutineService).not_to receive(:create_routines)
      user = FactoryGirl.create(:user, email: 'brian@quadfit.com', password: 'password', id: 100)
      FactoryGirl.create(:daily_routine, user: user, day_performed: Date.today)
      post :create, { email: 'brian@quadfit.com', password: 'password'}
    end
  end

  context 'sign out' do
    it 'signs out the user' do
      user = FactoryGirl.create(:user, email: 'brian@quadfit.com', password: 'password')
      sign_in user
      expect(subject.current_user).not_to be(nil)
      post :destroy
      expect(subject.current_user).to be(nil)
      expect(response.status).to eq(200)
    end
  end

end