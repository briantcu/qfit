require 'rails_helper'

RSpec.describe RoutineService do

  context 'cron job' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
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
        day_index = 0 if day_index == 7
      end
    end

    it 'creates workouts for all eligible users' do
      @user.last_sign_in_at = Time.now - 20.days
      @user.save!

      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(3)
    end

    it 'creates workouts for sub users without a group, regardless of last logged in' do
      coach = FactoryGirl.create(:user, level: 5, active_until: Time.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: coach)
      @user.master_user_id = coach.id
      @user.sub_user = true
      @user.last_sign_in_at = Time.now - 22.days
      @user.save!

      RoutineService.nightly_workout_creation
      expect(@user.reload.daily_routines.count).to eq(3)
    end

    it 'creates workouts for groups and members get the workout' do
      coach = FactoryGirl.create(:user, level: 5, active_until: Time.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: coach)
      group = FactoryGirl.create(:group, coach: coach)
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
        day_index = 0 if day_index == 7
      end

      sub_user = FactoryGirl.create(:user, sub_user: true)
      us = UserSchedule.create_user_schedule({user_id: sub_user.id, program_type_id: 1, program_id: 1})
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
    before(:each) do
      @user = FactoryGirl.create(:user, last_sign_in_at: Time.now - 3.days)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.program_id = 1
      @user_schedule.save!
      day_index = Date.today.wday
      2.times do
        wsd = @user_schedule.weekly_schedule_days.at(day_index)
        wsd.stretching = true
        wsd.plyometrics = true
        wsd.weights = true
        wsd.sprinting = true
        wsd.save
        day_index += 1
        day_index = 0 if day_index == 7
      end
    end

    context 'for user' do
      it 'if changes were saved, should copy over the added exercises, carry forward saved flag, keep deleted exercises deleted' do
        # Create 2 workouts, to complete full weights schedule
        RoutineService.nightly_workout_creation
        routine = @user.reload.daily_routines.first

        # Add exercises
        exercise = Exercise.first
        routine.add_weights(exercise, 1, 0)
        routine.note_weights_changed

        # Add custom sprint
        routine.add_custom_exercise('my sprint', 3, 0)
        routine.note_sprints_changed

        # Delete exercises
        pp = routine.performed_plyometrics.first
        pp.update_attributes(status: 2)
        routine.note_plyos_changed

        # Save changes
        routine.changes_saved = true
        routine.closed = true
        routine.save!

        # Create workout of same type
        date = Date.today + 7.days
        copied_routine = RoutineService.new(@user, 'CRON', date, false).create_routine

        # Expectations
        expect(copied_routine.changes_saved).to eq(true)
        expect(routine.performed_exercises.where(status: 3).count).to eq(copied_routine.performed_exercises.where(status: 3).count)
        expect(routine.performed_exercises.where(status: 2).count).to eq(copied_routine.performed_exercises.where(status: 2).count)
        expect(routine.performed_exercises.where(status: 1).count).to eq(copied_routine.performed_exercises.where(status: 1).count)
        expect(copied_routine.performed_exercises.count).to eq(9)
        expect(copied_routine.performed_exercises.first.weight_sets.count).to eq(4)

        expect(routine.performed_plyometrics.where(status: 3).count).to eq(copied_routine.performed_plyometrics.where(status: 3).count)
        expect(routine.performed_plyometrics.where(status: 2).count).to eq(copied_routine.performed_plyometrics.where(status: 2).count)
        expect(routine.performed_plyometrics.where(status: 2).count).to eq(1)
        expect(routine.performed_plyometrics.where(status: 1).count).to eq(copied_routine.performed_plyometrics.where(status: 1).count)
        expect(copied_routine.performed_plyometrics.count).to eq(4)

        expect(copied_routine.custom_exercises.count).to eq(1)

        expect(routine.performed_warm_ups.where(status: 3).count).to eq(copied_routine.performed_warm_ups.where(status: 3).count)
        expect(routine.performed_warm_ups.where(status: 2).count).to eq(copied_routine.performed_warm_ups.where(status: 2).count)
        expect(routine.performed_warm_ups.where(status: 1).count).to eq(copied_routine.performed_warm_ups.where(status: 1).count)
        expect(copied_routine.performed_warm_ups.count).to eq(6)

        expect(routine.performed_sprints.where(status: 3).count).to eq(copied_routine.performed_sprints.where(status: 3).count)
        expect(routine.performed_sprints.where(status: 2).count).to eq(copied_routine.performed_sprints.where(status: 2).count)
        expect(routine.performed_sprints.where(status: 1).count).to eq(copied_routine.performed_sprints.where(status: 1).count)
        expect(copied_routine.performed_sprints.count).to eq(1)
        expect(copied_routine.performed_sprints.first.laps.count).to eq(4)
      end

      it 'should not copy over added exercises if the changes were not saved' do

        # Create 2 workouts, to complete full weights schedule
        RoutineService.nightly_workout_creation
        routine = @user.reload.daily_routines.first

        # Add exercises
        exercise = Exercise.first
        routine.add_weights(exercise, 1, 0)
        routine.note_weights_changed

        # Add custom sprint
        routine.add_custom_exercise('my sprint', 3, 0)
        routine.note_sprints_changed

        # Delete exercises
        routine.performed_plyometrics.first.update_attributes(status: 2)
        routine.note_plyos_changed

        # Save changes
        routine.changes_saved = false
        routine.closed = true
        routine.save!

        # Create workout of same type
        date = Date.today + 7.days
        copied_routine = RoutineService.new(@user, 'CRON', date, false).create_routine

        expect(copied_routine.changes_saved).to eq(false)
        expect(routine.performed_exercises.where(status: 3).count).to eq(copied_routine.performed_exercises.where(status: 3).count)
        expect(copied_routine.performed_exercises.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_exercises.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_exercises.count).to eq(8)
        expect(copied_routine.performed_exercises.first.weight_sets.count).to eq(4)

        expect(routine.performed_plyometrics.where(status: 3).count + 1).to eq(copied_routine.performed_plyometrics.where(status: 3).count)
        expect(copied_routine.performed_plyometrics.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_plyometrics.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_plyometrics.count).to eq(4)

        expect(copied_routine.custom_exercises.count).to eq(0)

        expect(routine.performed_warm_ups.where(status: 3).count).to eq(copied_routine.performed_warm_ups.where(status: 3).count)
        expect(copied_routine.performed_warm_ups.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_warm_ups.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_warm_ups.count).to eq(6)

        expect(routine.performed_sprints.where(status: 3).count).to eq(copied_routine.performed_sprints.where(status: 3).count)
        expect(copied_routine.performed_sprints.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_sprints.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_sprints.count).to eq(1)
        expect(copied_routine.performed_sprints.first.laps.count).to eq(4)

      end

      it 'copies over a completely custom day with changes saved and has the right program day id' do
        routine = DailyRoutine.create_routine(@user.id, Date.today + 3.days, 0, 0) # When this user has nothing scheduled
        routine.add_custom_exercise('my sprint', 3, 0)
        routine.add_custom_exercise('my warmup', 4, 0)
        routine.add_custom_exercise('my plyo', 2, 0)
        routine.add_custom_exercise('my weights', 1, 0)
        routine.note_warmups_changed
        routine.note_plyos_changed
        routine.note_sprints_changed
        routine.note_weights_changed
        routine.changes_saved = true
        routine.closed = true
        routine.save!

        date = Date.today + 10.days
        copied_routine = RoutineService.new(@user, 'CRON', date, false).create_routine
        expect(copied_routine.custom_exercises.count).to eq(4)
        expect(copied_routine.changes_saved).to eq(false)
      end
    end

    context 'for group' do
      before(:each) do
        coach = FactoryGirl.create(:user, level: 5, active_until: Time.now + 7.days, status: 1)
        FactoryGirl.create(:coach_account, user: coach)
        @group = FactoryGirl.create(:group, coach: coach)
        @group_schedule = FactoryGirl.create(:group_schedule, group: @group)
        @group_schedule.setup_phases
        @group_schedule.program_id = 1
        @group_schedule.save!

        @sub_user = FactoryGirl.create(:user, sub_user: true)
        UserSchedule.create_user_schedule({user_id: @sub_user.id, program_type_id: 1, program_id: 1})
        @group.add_member(@sub_user)
        day_index = Date.today.wday
        2.times do
          wsd = @group_schedule.group_schedule_days.at(day_index)
          wsd.stretching = true
          wsd.plyometrics = true
          wsd.weights = true
          wsd.sprinting = true
          wsd.save
          day_index += 1
          day_index = 0 if day_index == 7
        end
      end

      it 'if changes were saved, should copy over the added exercises, carry forward saved flag, keep deleted exercises deleted' do
        RoutineService.nightly_workout_creation
        routine = @group.reload.group_routines.first

        # Add exercises
        exercise = Exercise.first
        routine.add_weights(exercise, 1, 0)
        routine.note_weights_changed(true)

        # Add custom sprint
        routine.add_custom_exercise('my sprint', 3, 0)
        routine.note_sprints_changed(true)

        # Delete exercises
        routine.group_performed_plyos.first.destroy_ex
        routine.note_plyos_changed(true)

        # Save changes
        routine.changes_saved = true
        routine.save!

        # Create workout of same type
        date = Date.today + 7.days
        RoutineService.new(@group, 'CRON', date, false).create_routine

        routine = @sub_user.daily_routines.first
        copied_routine = @sub_user.daily_routines.last

        expect(routine.performed_exercises.where(status: 3).count).to eq(copied_routine.performed_exercises.where(status: 3).count)
        expect(routine.performed_exercises.where(status: 2).count).to eq(copied_routine.performed_exercises.where(status: 2).count)
        expect(routine.performed_exercises.where(status: 1).count).to eq(copied_routine.performed_exercises.where(status: 1).count)
        expect(copied_routine.performed_exercises.count).to eq(9)
        expect(copied_routine.performed_exercises.first.weight_sets.count).to eq(4)

        expect(routine.performed_plyometrics.where(status: 3).count).to eq(copied_routine.performed_plyometrics.where(status: 3).count)
        expect(routine.performed_plyometrics.where(status: 2).count).to eq(copied_routine.performed_plyometrics.where(status: 2).count)
        expect(routine.performed_plyometrics.where(status: 2).count).to eq(1)
        expect(routine.performed_plyometrics.where(status: 1).count).to eq(copied_routine.performed_plyometrics.where(status: 1).count)
        expect(copied_routine.performed_plyometrics.count).to eq(4)

        expect(copied_routine.custom_exercises.count).to eq(1)

        expect(routine.performed_warm_ups.where(status: 3).count).to eq(copied_routine.performed_warm_ups.where(status: 3).count)
        expect(routine.performed_warm_ups.where(status: 2).count).to eq(copied_routine.performed_warm_ups.where(status: 2).count)
        expect(routine.performed_warm_ups.where(status: 1).count).to eq(copied_routine.performed_warm_ups.where(status: 1).count)
        expect(copied_routine.performed_warm_ups.count).to eq(6)

        expect(routine.performed_sprints.where(status: 3).count).to eq(copied_routine.performed_sprints.where(status: 3).count)
        expect(routine.performed_sprints.where(status: 2).count).to eq(copied_routine.performed_sprints.where(status: 2).count)
        expect(routine.performed_sprints.where(status: 1).count).to eq(copied_routine.performed_sprints.where(status: 1).count)
        expect(copied_routine.performed_sprints.count).to eq(1)
        expect(copied_routine.performed_sprints.first.laps.count).to eq(4)
      end

      it 'should not copy over added exercises if the changes were not saved' do
        RoutineService.nightly_workout_creation
        routine = @group.reload.group_routines.first

        # Add exercises
        exercise = Exercise.first
        routine.add_weights(exercise, 1, 0)
        routine.note_weights_changed(true)

        # Add custom sprint
        routine.add_custom_exercise('my sprint', 3, 0)
        routine.note_sprints_changed(true)

        # Delete exercises
        routine.group_performed_plyos.first.destroy_ex
        routine.note_plyos_changed(true)

        # Save changes
        routine.changes_saved = false
        routine.save!

        # Create workout of same type
        date = Date.today + 7.days
        RoutineService.new(@group, 'CRON', date, false).create_routine

        routine = @sub_user.daily_routines.first
        copied_routine = @sub_user.daily_routines.last
        expect(copied_routine.changes_saved).to eq(false)
        expect(routine.performed_exercises.where(status: 3).count).to eq(copied_routine.performed_exercises.where(status: 3).count)
        expect(copied_routine.performed_exercises.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_exercises.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_exercises.count).to eq(8)
        expect(copied_routine.performed_exercises.first.weight_sets.count).to eq(4)

        expect(routine.performed_plyometrics.where(status: 3).count + 1).to eq(copied_routine.performed_plyometrics.where(status: 3).count)
        expect(copied_routine.performed_plyometrics.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_plyometrics.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_plyometrics.count).to eq(4)

        expect(copied_routine.custom_exercises.count).to eq(0)

        expect(routine.performed_warm_ups.where(status: 3).count).to eq(copied_routine.performed_warm_ups.where(status: 3).count)
        expect(copied_routine.performed_warm_ups.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_warm_ups.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_warm_ups.count).to eq(6)

        expect(routine.performed_sprints.where(status: 3).count).to eq(copied_routine.performed_sprints.where(status: 3).count)
        expect(copied_routine.performed_sprints.where(status: 2).count).to eq(0)
        expect(copied_routine.performed_sprints.where(status: 1).count).to eq(0)
        expect(copied_routine.performed_sprints.count).to eq(1)
        expect(copied_routine.performed_sprints.first.laps.count).to eq(4)

      end

      it 'copies over a completely custom day with changes saved and has the right program day id' do
        routine = GroupRoutine.create_routine(@group.id, Date.today + 3.days) # When this user has nothing scheduled
        routine.add_custom_exercise('my sprint', 3, 0)
        routine.add_custom_exercise('my warmup', 4, 0)
        routine.add_custom_exercise('my plyo', 2, 0)
        routine.add_custom_exercise('my weights', 1, 0)
        routine.note_warmups_changed(true)
        routine.note_plyos_changed(true)
        routine.note_sprints_changed(true)
        routine.note_weights_changed(true)
        routine.changes_saved = true
        routine.save!

        date = Date.today + 10.days
        RoutineService.new(@group, 'CRON', date, false).create_routine
        copied_routine = @sub_user.daily_routines.last
        expect(copied_routine.custom_exercises.count).to eq(4)
        expect(copied_routine.changes_saved).to eq(false)
      end
    end
  end

  context 'for group' do
    before(:each) do
      coach = FactoryGirl.create(:user, level: 5, active_until: Time.now + 7.days, status: 1)
      FactoryGirl.create(:coach_account, user: coach)
      @group = FactoryGirl.create(:group, coach: coach)
      @group_schedule = FactoryGirl.create(:group_schedule, group: @group)
      @group_schedule.setup_phases
      @group_schedule.program_id = 1
      @group_schedule.save!

      @sub_user = FactoryGirl.create(:user, sub_user: true)
      UserSchedule.create_user_schedule({user_id: @sub_user.id, program_type_id: 1, program_id: 1})
      @group.add_member(@sub_user)
      day_index = Date.today.wday
      2.times do
        wsd = @group_schedule.group_schedule_days.at(day_index)
        wsd.stretching = true
        wsd.plyometrics = true
        wsd.weights = true
        wsd.sprinting = true
        wsd.save
        day_index += 1
        day_index = 0 if day_index == 7
      end
    end

    it 'deletes all exercises when a routine is deleted' do
      RoutineService.nightly_workout_creation
      group_routine = @group.reload.group_routines.first
      expect(group_routine).not_to be(nil)

      routine = @sub_user.daily_routines.first
      expect(routine.group_routine_id).to eq(group_routine.id)
      expect(@sub_user.daily_routines.count).to eq(2)
      expect(PerformedExercise.where(routine_id: routine.id).count > 0).to be(true)

      group_routine.destroy
      expect(@sub_user.reload.daily_routines.count).to eq(1)
      expect(PerformedExercise.where(routine_id: routine.id).count > 0).to be(false)
    end

    it 'deletes sub user routines when a sub user is deleted' do
      RoutineService.nightly_workout_creation
      group_routine = @group.reload.group_routines.first
      expect(group_routine).not_to be(nil)

      expect(DailyRoutine.where(group_routine_id: group_routine.id).count > 0).to be(true)

      @sub_user.destroy
      expect(DailyRoutine.where(group_routine_id: group_routine.id).count > 0).to be(false)
    end

    it 'does not delete group routines when a group is deleted' do
      RoutineService.nightly_workout_creation
      @group.destroy
      expect(GroupRoutine.where(group_id: @group.id).count > 0).to be(true)
      expect(@sub_user.reload.group).to be(nil)
    end

  end

  context 'for user' do
    before(:each) do
      @user = FactoryGirl.create(:user, last_sign_in_at: Time.now - 3.days)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
      @user_schedule.create_weekly_schedule_days
      @user_schedule.setup_phases
      @user_schedule.program_id = 1
      @user_schedule.save!
      day_index = Date.today.wday
      2.times do
        wsd = @user_schedule.weekly_schedule_days.at(day_index)
        wsd.stretching = true
        wsd.plyometrics = true
        wsd.weights = true
        wsd.sprinting = true
        wsd.save
        day_index += 1
        day_index = 0 if day_index == 7
      end
    end

    it 'deletes all sets when an exercise is deleted' do
      RoutineService.nightly_workout_creation
      routine = @user.reload.daily_routines.first

      # Add exercises
      exercise = Exercise.first
      perf_ex = routine.add_weights(exercise, 1, 0)
      expect(WeightSet.where(performed_exercise: perf_ex).count > 0).to be(true)

      perf_ex.destroy
      expect(WeightSet.where(performed_exercise: perf_ex).count > 0).to be(false)
    end
  end
end