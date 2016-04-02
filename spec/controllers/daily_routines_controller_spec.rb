require 'rails_helper'

RSpec.describe DailyRoutinesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'returns the last 5 daily routines for a user' do
    FactoryGirl.create(:daily_routine, user: @user)
    FactoryGirl.create(:daily_routine, user: @user)
    FactoryGirl.create(:daily_routine, user: @user)
    FactoryGirl.create(:daily_routine, user: @user)
    FactoryGirl.create(:daily_routine, user: @user)
    FactoryGirl.create(:daily_routine, user: @user)
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

end