require 'rails_helper'

RSpec.describe WorkoutManagementController, type: :controller do

  before(:each) do
    allow_any_instance_of(User).to receive(:has_premium_access?).and_return(true)
  end

  context 'schedule' do
    it 'should redirect to goal if the user does not have a schedule' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :schedule
      expect(response).to redirect_to('/setup/goal')
    end

    it 'should redirect to quads if a team does not have a schedule' do
      coach = FactoryGirl.create(:user, level: 5)
      team = FactoryGirl.create(:group)
      sign_in coach
      session[:viewing] = 'team'
      session[:team_id] = team.id
      get :schedule
      expect(response).to redirect_to('/setup/quads')
    end

    it 'is successful' do
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:user_schedule, user: user, phase_one_start: Time.now)
      sign_in user
      get :schedule
    end

    context 'coach is logged in' do
      it 'should redirect to /coach if we cannot figure out what entity the coach is viewing' do
        coach = FactoryGirl.create(:user, level: 5)
        sign_in coach
        get :schedule
        expect(response).to redirect_to('/coach')
      end

      it 'is successful' do
        coach = FactoryGirl.create(:user, level: 5)
        team = FactoryGirl.create(:group)
        FactoryGirl.create(:group_schedule, group: team, phase_one_start: Time.now)
        sign_in coach
        session[:viewing] = 'team'
        session[:team_id] = team.id
        get :schedule
        expect(response.status).to eq(200)
      end
    end
  end

  context 'setup' do
    it 'redirects for a coach that has not chosen an entity' do
      coach = FactoryGirl.create(:user, level: 5)
      sign_in coach
      get :setup_goal
      expect(response).to redirect_to('/coach')
    end

    it 'is successful' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :setup_goal
      expect(response.status).to eq(200)
    end
  end

  context 'do work' do
    it 'redirects for a coach that has not chosen an entity' do
      coach = FactoryGirl.create(:user, level: 5)
      sign_in coach
      get :do_work
      expect(response).to redirect_to('/coach')
    end

    it 'redirects if the entity has not completed setup' do
      coach = FactoryGirl.create(:user, level: 5)
      team = FactoryGirl.create(:group)
      sign_in coach
      session[:viewing] = 'team'
      session[:team_id] = team.id
      get :do_work
      expect(response).to redirect_to('/setup/quads')
    end

    it 'is successful' do
      coach = FactoryGirl.create(:user, level: 5)
      team = FactoryGirl.create(:group)
      FactoryGirl.create(:group_schedule, group: team, phase_one_start: Time.now)
      sign_in coach
      session[:viewing] = 'team'
      session[:team_id] = team.id
      get :schedule
      expect(response.status).to eq(200)
    end
  end

  context 'setup redirect' do
    it 'redirects for /program' do
      user = FactoryGirl.create(:user)
      sign_in user
      get :setup_redirect
      expect(response).to redirect_to('/setup/goal')
    end
  end

end