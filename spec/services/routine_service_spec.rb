require 'rails_helper'

RSpec.describe RoutineService do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user_schedule = FactoryGirl.create(:user_schedule, user: @user)
    @user_schedule.create_weekly_schedule_days
    @user_schedule.setup_phases
    @user_schedule.save!
  end

  context 'cron job' do
    it 'creates workouts for all eligible users' do
      @user.last_sign_in_at = Time.now - 20.days
      @user.save!

      allow_any_instance_of(UserSchedule).to receive(:is_valid_workout_day?).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:stretching).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:sprinting).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:plyometrics).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:weights).and_return(true)

      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(3)
    end

    it 'creates workouts for sub users without a group, regardless of last logged in' do
      @user.sub_user = true
      @user.save!

      allow_any_instance_of(UserSchedule).to receive(:is_valid_workout_day?).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:stretching).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:sprinting).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:plyometrics).and_return(true)
      allow_any_instance_of(WeeklyScheduleDay).to receive(:weights).and_return(true)

      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(3)
    end

    it 'creates workouts for groups and members get the workout' do
      group = FactoryGirl.create(:group)
      group_schedule = FactoryGirl.create(:group_schedule, group: group)
      group_schedule.create_weekly_schedule_days
      group_schedule.setup_phases
      group_schedule.save!
      sub_user = FactoryGirl.create(:user, sub_user: true)
      group.add_member(sub_user)

      allow_any_instance_of(GroupSchedule).to receive(:is_valid_workout_day?).and_return(true)
      allow_any_instance_of(GroupScheduleDay).to receive(:stretching).and_return(true)
      allow_any_instance_of(GroupScheduleDay).to receive(:sprinting).and_return(true)
      allow_any_instance_of(GroupScheduleDay).to receive(:plyometrics).and_return(true)
      allow_any_instance_of(GroupScheduleDay).to receive(:weights).and_return(true)

      RoutineService.nightly_workout_creation
      expect(sub_user.reload.daily_routines.count).to eq(3)
    end

    it 'does not create workouts for users that have not logged in recently' do
      allow(@user_schedule).to receive(:is_valid_workout_day?).and_return(true)
      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(0)
    end
  end

  context 'previous matching routine' do
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

  end

  context 'no previous matching routine' do
    it 'creates a routine with all quads' do
      #pluck IDs of exercises and verify they're unique
    end
  end

end