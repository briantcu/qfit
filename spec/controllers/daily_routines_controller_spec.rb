# == Schema Information
#
# Table name: daily_routines
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  group_id           :integer
#  day_performed      :date
#  weight             :integer
#  power_index        :integer
#  count_ex_provided  :integer
#  count_ex_completed :integer
#  program_day_id     :integer
#  wt_day_id          :integer
#  sp_day_id          :integer
#  pl_day_id          :integer
#  wu_day_id          :integer
#  modified           :boolean          default(FALSE)
#  pl_modified        :boolean          default(FALSE)
#  wt_modified        :boolean          default(FALSE)
#  wu_modified        :boolean          default(FALSE)
#  sp_modified        :boolean          default(FALSE)
#  changes_saved      :boolean          default(FALSE)
#  closed             :boolean          default(FALSE)
#  created_at         :datetime
#  updated_at         :datetime
#  group_routine_id   :integer
#  shared             :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe DailyRoutinesController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    FactoryGirl.create(:user_schedule, user: @user, program_type_id: 1, program_id: 1)
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

  it 'adds a weights exercise' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)

    sign_in @user
    expect_any_instance_of(DailyRoutine).to receive(:note_weights_changed)
    post :add_weight, id: dr.id, exercise_id: 3, format: :json
    expect(response.status).to eq(200)
    expect(dr.performed_exercises.count).to eq(1)
  end

  it 'adds a sprint' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)

    sign_in @user
    expect_any_instance_of(DailyRoutine).to receive(:note_sprints_changed)
    post :add_sprint, id: dr.id, sprint_id: 2, format: :json
    expect(response.status).to eq(200)
    expect(dr.performed_sprints.count).to eq(1)
  end

  it 'adds a warmup' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)

    sign_in @user
    expect_any_instance_of(DailyRoutine).to receive(:note_warmups_changed)
    post :add_warmup, id: dr.id, warmup_id: 2, format: :json
    expect(response.status).to eq(200)
    expect(dr.performed_warm_ups.count).to eq(1)
  end

  it 'adds a plyo' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)

    sign_in @user
    expect_any_instance_of(DailyRoutine).to receive(:note_plyos_changed)
    post :add_plyo, id: dr.id, plyometric_id: 2, format: :json
    expect(response.status).to eq(200)
    expect(dr.performed_plyometrics.count).to eq(1)
  end

  it 'adds a custom exercise' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)

    sign_in @user
    post :add_custom, id: dr.id, name: 'my custom', type: 1, format: :json
    expect(response.status).to eq(200)
    expect(dr.custom_exercises.count).to eq(1)
  end

  it 'does not add an exercise if maxed out' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)
    15.times do
      FactoryGirl.create(:performed_exercise, daily_routine: dr)
    end
    sign_in @user
    post :add_weight, id: dr.id, exercise_id: 2, format: :json
    expect(response.status).to eq(406)
    expect(dr.performed_exercises.count).to eq(15)
  end

  it 'assigns user points and notes as shared' do
    dr = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today - 2.days)
    sign_in @user
    put :shared, id: dr.id, format: :json
    body = JSON.parse(response.body)
    expect(response.status).to eq(200)
    expect(body['shared']).to eq(true)
    expect(@user.reload.points).to eq(10)
  end

end
