require 'rails_helper'

RSpec.describe RoutineService do

  before(:each) do
    user = FactoryGirl.create(:user)
    user_schedule = FactoryGirl.create(:user_schedule, user: user)
  end

  context 'cron job' do
    it 'creates workouts for all eligible users' do


    end

    it 'creates workouts for sub users without a group' do
      group = FactoryGirl.create(:group)
    end

    it 'creates workouts for groups and members get the workout' do

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