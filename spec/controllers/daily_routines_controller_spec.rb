require 'rails_helper'

RSpec.describe DailyRoutinesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'returns the last 5 daily routines for a user' do
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 1.days)
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 2.days)
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 3.days)
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 4.days)
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 5.days)
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 6.days)
    sign_in @user
    get :index, format: :json
    body = JSON.parse(response.body)
    expect(body.count).to eq(5)
  end

  it 'returns a routine if you own it' do
    sign_in @user
    dr = FactoryGirl.create(:daily_routine, user: @user)
    get :show, id: dr.id, format: :json
    body = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(body['id']).to eq(dr.id)
  end

  it 'returns 401 if logged out' do
    dr = FactoryGirl.create(:daily_routine, user: @user)
    get :show, id: dr.id
    expect(response.status).to eq(401)
  end

  it 'returns 401 if youre a coach and you dont own the user' do
    coach = FactoryGirl.create(:user, level: 5)
    sign_in coach
    player = FactoryGirl.create(:user, level: 1)
    dr = FactoryGirl.create(:daily_routine, user: player)
    get :show, id: dr.id
    expect(response.status).to eq(401)
  end

  it 'does not allow create if not logged in' do
    post :create, daily_routine: { user_id: 1, day_peformed: Date.today}, format: :json
    expect(response.status).to eq(401)
  end

  it 'creates a new workout on a day that you dont have one' do
    sign_in @user
    post :create, daily_routine: { user_id: @user.id, year: 2016, month: 4, day: 2}, format: :json
    body = JSON.parse(response.body)
    expect(body['id']).not_to be(nil)
  end

  it 'returns old workout if you try to create one for an existing day' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
    sign_in @user
    post :create, daily_routine: { user_id: @user.id, year: dr.day_performed.year, month: dr.day_performed.month, day: dr.day_performed.day}, format: :json
    body = JSON.parse(response.body)
    expect(body['id']).to eq(dr.id)
  end

  it 'returns a workout for a given date' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
    sign_in @user
    get :routine_by_date, user_id: @user.id, year: dr.day_performed.year, month: dr.day_performed.month, day: dr.day_performed.day, format: :json
    body = JSON.parse(response.body)
    expect(body['id']).to eq(dr.id)
  end

  it 'allows you to skip all workouts up to today' do
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)
    FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 1.days)
    expect(@user.daily_routines.select { |dr| !dr.closed}.count).to eq(2)
    sign_in @user
    put :skip_all, user_id: @user.id, format: :json
    expect(@user.daily_routines(true).select { |dr| !dr.closed}.count).to eq(0)
  end

  it 'skips a single workout' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)
    sign_in @user
    put :skip, id: dr.id, format: :json
    expect(dr.reload.closed).to eq(true)
  end

  it 'closes a workout' do
    allow(GoalDefinition).to receive(:find).and_return(FactoryGirl.create(:goal_definition))
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)
    sign_in @user
    put :close, id: dr.id, format: :json, daily_routine: { weight: 200, changes_saved: true }
    body = JSON.parse(response.body)
    expect(body['weight']).to eq(200)
    expect(body['messages'].count).to eq(1)
  end

end
