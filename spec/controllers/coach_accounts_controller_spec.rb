require 'rails_helper'

RSpec.describe CoachAccountsController, type: :controller do

  before(:each) do
    @coach = FactoryGirl.create(:user, level: 5)
    @coach_account = FactoryGirl.create(:coach_account, user: @coach)
  end

  context 'logged in' do
    before(:each) do
      sign_in @coach
    end

    it 'should add a new user' do
      new_user = FactoryGirl.create(:user, email: 'briantcu@gmail.com')
      allow_any_instance_of(RegistrationService).to receive(:register_user_for_coach).and_return(new_user)
      post :add_user, id: @coach_account.id, user: {email: 'briantcu@gmail.com', first_name: 'brian', last_name: 'regan', sex: 'male'}, format: :json
      body = JSON.parse(response.body)
      expect(body['first_name']).to eq('Brian')
      expect(body['last_name']).to eq('Regan')
      expect(body['id']).not_to eq(nil)
    end

    it 'should delete a user you own' do
      player = FactoryGirl.create(:user, level: 1, master_user_id: @coach.id)
      expect(@coach.players.count).to eq(1)
      delete :delete_user, id: @coach_account.id, user_id: player.id, format: :json
      expect(response.status).to eq(201)
      expect(@coach.players.count).to eq(0)
    end
  end

end