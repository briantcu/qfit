# == Schema Information
#
# Table name: coach_accounts
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  num_accts     :integer
#  billing_email :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  active        :boolean          default(TRUE)
#  active_until  :datetime
#

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

    it 'should delete a user you own' do
      player = FactoryGirl.create(:user, level: 1, master_user_id: @coach.id)
      expect(@coach.players.count).to eq(1)
      expect(EmailService).to receive(:perform_async).with(:coach_deleted_you, {email: player.email})
      delete :delete_user, id: @coach_account.id, user_id: player.id, format: :json
      expect(response.status).to eq(200)
      expect(@coach.players.count).to eq(0)
    end

    it 'should show your account' do
      FactoryGirl.create(:user, level: 1, master_user_id: @coach.id)
      FactoryGirl.create(:sign_up_code, user: @coach)
      expect(@coach.players.count).to eq(1)
      get :show, id: @coach_account.id, format: :json
      expect(response.status).to eq(200)
    end

    it 'should call coach invite service to send an invite' do
      group = FactoryGirl.create(:group)
      allow_any_instance_of(CoachInviteService).to receive(:send_invite).with('briantcu@gmail.com', @coach_account, 'team', group.id, nil).and_return({ status: 'success', message: 'Success', sent_code: '123'})
      post :send_invite, id: @coach_account.id, send_to: 'briantcu@gmail.com', sign_up_type: 'team', template_id: group.id, format: :json
    end
  end

  context 'invalid credentials' do
    it 'should not allow a coach to delete a user they dont own' do
      sign_in @coach
      user = FactoryGirl.create(:user)
      delete :delete_user, id: @coach_account.id, user_id: user.id, format: :json
      expect(response.status).to eq(401)
    end

    it 'should not allow access to coach account' do
      get :show, id: @coach_account.id, format: :json
      expect(response.status).to eq(401)
    end
  end

end
