require 'rails_helper'

RSpec.describe RoutineService do

  context 'cron job' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user_schedule = FactoryGirl.create(:user_schedule, user: @user)
      @user_schedule.setup_phases
      @user_schedule.save!
      day_index = Date.today.wday
      3.times do
        wsd = @user_schedule.weekly_schedule_days.at(day_index)
        wsd.stretching = true
        wsd.plyometrics = true
        wsd.weights = true
        wsd.sprinting = true
        wsd.save
        day_index += 1
      end
    end

    it 'creates workouts for all eligible users' do
      @user.last_sign_in_at = Time.now - 20.days
      @user.save!

      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(3)
    end

    it 'creates workouts for sub users without a group, regardless of last logged in' do
      @user.sub_user = true
      @user.last_sign_in_at = Time.now - 22.days
      @user.save!

      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(3)
    end

    it 'creates workouts for groups and members get the workout' do
      group = FactoryGirl.create(:group)
      group_schedule = FactoryGirl.create(:group_schedule, group: group)
      group_schedule.setup_phases
      group_schedule.save!

      day_index = Date.today.wday
      3.times do
        wsd = group_schedule.group_schedule_days.at(day_index)
        wsd.stretching = true
        wsd.plyometrics = true
        wsd.weights = true
        wsd.sprinting = true
        wsd.save!
        day_index += 1
      end

      sub_user = FactoryGirl.create(:user, sub_user: true)
      group.add_member(sub_user)

      RoutineService.nightly_workout_creation
      expect(sub_user.reload.daily_routines.count).to eq(3)
    end

    it 'does not create workouts for users that have not logged in recently' do
      allow(@user_schedule).to receive(:is_valid_workout_day?).and_return(true)
      @user.last_sign_in_at = Time.now - 22.days
      @user.save!
      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(0)
    end
  end

  context 'previous matching routine' do
    context 'for user' do
      it 'should copy over the exercises if the workout was not modified' do

      end

      it 'should copy over the added exercises if changes were saved and carry forward saved flag' do

      end

      it 'should not copy over added exercises if the changes were not saved' do

      end

      it 'should keep deleted exercises deleted if changes were saved' do

      end

      it 'copies over a completely custom day with changes saved and has the right program day id' do

      end
    end

    context 'for group' do
      it 'should copy over the exercises if the workout was not modified' do

      end

      it 'should copy over the added exercises if changes were saved and carry forward saved flag' do

      end

      it 'should not copy over added exercises if the changes were not saved' do

      end

      it 'should keep deleted exercises deleted if changes were saved' do

      end

      it 'copies over a completely custom day with changes saved and has the right program day id' do

      end
    end
  end

  context 'no previous matching routine' do
    it 'creates a routine with all quads' do
      #pluck IDs of exercises and verify they're unique
    end
  end

end