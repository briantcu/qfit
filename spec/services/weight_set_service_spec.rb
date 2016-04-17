require 'rails_helper'

RSpec.describe WeightSetService do

  context 'returns the correct values based on previous user max' do
    context 'for males' do
      before(:each) do
        @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200)
        @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
        @user_schedule.setup_phases
        @user_schedule.save!
        @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      end

      it 'returns med ball sets' do
        # Med ball 1 2 3
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(96), exercise_type: Exercise.find(96).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(8)
        expect(sets[1].rec_weight).to eq(8)
        expect(sets[2].rec_weight).to eq(8)
        expect(sets[3].rec_weight).to eq(8)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns body weight sets' do
        # Dips
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(57), exercise_type: Exercise.find(57).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(0)
        expect(sets[1].rec_weight).to eq(0)
        expect(sets[2].rec_weight).to eq(0)
        expect(sets[3].rec_weight).to eq(0)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns assisted body weight sets' do
        # Assisted pull up
        UserMax.create(user: @user, exercise_id: 54, max: 225, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(54), exercise_type: Exercise.find(54).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(90)
        expect(sets[1].rec_weight).to eq(90)
        expect(sets[2].rec_weight).to eq(90)
        expect(sets[3].rec_weight).to eq(75)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns power exercise sets' do
        # Clean pull
        UserMax.create(user: @user, exercise_id: 1, max: 265, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(90)
        expect(sets[0].rec_weight).to eq(190)
        expect(sets[1].rec_weight).to eq(200)
        expect(sets[2].rec_weight).to eq(215)
        expect(sets[3].rec_weight).to eq(225)
        expect(sets[0].rec_reps).to eq(6)
        expect(sets[1].rec_reps).to eq(6)
        expect(sets[2].rec_reps).to eq(6)
        expect(sets[3].rec_reps).to eq(6)
      end

      it 'returns barbell sets' do
        # Bench
        UserMax.create(user: @user, exercise_id: 47, max: 225, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(47), exercise_type: Exercise.find(47).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(110)
        expect(sets[1].rec_weight).to eq(115)
        expect(sets[2].rec_weight).to eq(120)
        expect(sets[3].rec_weight).to eq(125)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns dumbbell sets' do
        # DB Press
        UserMax.create(user: @user, exercise_id: 61, max: 100, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(61), exercise_type: Exercise.find(61).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(50)
        expect(sets[1].rec_weight).to eq(50)
        expect(sets[2].rec_weight).to eq(55)
        expect(sets[3].rec_weight).to eq(55)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns plate sets' do
        # Corkscrew
        UserMax.create(user: @user, exercise_id: 87, max: 65, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(87), exercise_type: Exercise.find(87).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(25)
        expect(sets[1].rec_weight).to eq(25)
        expect(sets[2].rec_weight).to eq(25)
        expect(sets[3].rec_weight).to eq(35)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns cable sets' do
        # Cable wood chop
        UserMax.create(user: @user, exercise_id: 91, max: 150, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(91), exercise_type: Exercise.find(91).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(75)
        expect(sets[1].rec_weight).to eq(75)
        expect(sets[2].rec_weight).to eq(75)
        expect(sets[3].rec_weight).to eq(90)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'gets body weight with weight belt sets' do
        # Dip with dip belt
        UserMax.create(user: @user, exercise_id: 59, max: 350, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(59), exercise_type: Exercise.find(59).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(0)
        expect(sets[1].rec_weight).to eq(0)
        expect(sets[2].rec_weight).to eq(0)
        expect(sets[3].rec_weight).to eq(0)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end
    end

    context 'for females' do
      before(:each) do
        @user = FactoryGirl.create(:user, hor_push_max: 80, sex: 'female', weight: 120)
        @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
        @user_schedule.setup_phases
        @user_schedule.save!
        @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      end
      it 'returns med ball sets' do
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(96), exercise_type: Exercise.find(96).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(4)
        expect(sets[1].rec_weight).to eq(4)
        expect(sets[2].rec_weight).to eq(4)
        expect(sets[3].rec_weight).to eq(4)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns body weight sets' do
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(57), exercise_type: Exercise.find(57).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(0)
        expect(sets[1].rec_weight).to eq(0)
        expect(sets[2].rec_weight).to eq(0)
        expect(sets[3].rec_weight).to eq(0)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns assisted body weight sets' do
        # Assisted pull up
        UserMax.create(user: @user, exercise_id: 54, max: 100, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(54), exercise_type: Exercise.find(54).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(75)
        expect(sets[1].rec_weight).to eq(75)
        expect(sets[2].rec_weight).to eq(75)
        expect(sets[3].rec_weight).to eq(60)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns power exercise sets' do
        # Clean pull
        UserMax.create(user: @user, exercise_id: 1, max: 130, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(90)
        expect(sets[0].rec_weight).to eq(95)
        expect(sets[1].rec_weight).to eq(100)
        expect(sets[2].rec_weight).to eq(105)
        expect(sets[3].rec_weight).to eq(110)
        expect(sets[0].rec_reps).to eq(6)
        expect(sets[1].rec_reps).to eq(6)
        expect(sets[2].rec_reps).to eq(6)
        expect(sets[3].rec_reps).to eq(6)
      end

      it 'returns barbell sets' do
        # Bench
        UserMax.create(user: @user, exercise_id: 47, max: 115, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(47), exercise_type: Exercise.find(47).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(55)
        expect(sets[1].rec_weight).to eq(60)
        expect(sets[2].rec_weight).to eq(60)
        expect(sets[3].rec_weight).to eq(65)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns dumbbell sets' do
        # DB Press
        UserMax.create(user: @user, exercise_id: 61, max: 40, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(61), exercise_type: Exercise.find(61).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(20)
        expect(sets[1].rec_weight).to eq(20)
        expect(sets[2].rec_weight).to eq(20)
        expect(sets[3].rec_weight).to eq(22.5)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'gets body weight with weight belt sets' do
        # Dip with dip belt
        UserMax.create(user: @user, exercise_id: 59, max: 250, created_at: Time.now - 3.days)
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(59), exercise_type: Exercise.find(59).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(0)
        expect(sets[1].rec_weight).to eq(5)
        expect(sets[2].rec_weight).to eq(12.5)
        expect(sets[3].rec_weight).to eq(20)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end
    end

  end

  context 'returns the correct values with no previous user max' do
    context 'for males' do
      before(:each) do
        @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
        @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
        @user_schedule.setup_phases
        @user_schedule.save!
        @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      end

      it 'returns assisted body weight sets' do
        # Assisted pull up
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(54), exercise_type: Exercise.find(54).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(60)
        expect(sets[1].rec_weight).to eq(50)
        expect(sets[2].rec_weight).to eq(40)
        expect(sets[3].rec_weight).to eq(30)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns power exercise sets' do
        # Clean pull
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(90)
        expect(sets[0].rec_weight).to eq(125)
        expect(sets[1].rec_weight).to eq(130)
        expect(sets[2].rec_weight).to eq(140)
        expect(sets[3].rec_weight).to eq(145)
        expect(sets[0].rec_reps).to eq(6)
        expect(sets[1].rec_reps).to eq(6)
        expect(sets[2].rec_reps).to eq(6)
        expect(sets[3].rec_reps).to eq(6)
      end

      it 'returns barbell sets' do
        # Bench
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(47), exercise_type: Exercise.find(47).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(80)
        expect(sets[1].rec_weight).to eq(85)
        expect(sets[2].rec_weight).to eq(90)
        expect(sets[3].rec_weight).to eq(90)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns dumbbell sets' do
        # DB Press
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(61), exercise_type: Exercise.find(61).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(20)
        expect(sets[1].rec_weight).to eq(20)
        expect(sets[2].rec_weight).to eq(20)
        expect(sets[3].rec_weight).to eq(22.5)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns plate sets' do
        # Corkscrew
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(87), exercise_type: Exercise.find(87).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(10)
        expect(sets[1].rec_weight).to eq(10)
        expect(sets[2].rec_weight).to eq(10)
        expect(sets[3].rec_weight).to eq(10)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'returns cable sets' do
        # Cable wood chop
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(91), exercise_type: Exercise.find(91).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(40)
        expect(sets[1].rec_weight).to eq(40)
        expect(sets[2].rec_weight).to eq(50)
        expect(sets[3].rec_weight).to eq(50)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

      it 'gets body weight with weight belt sets' do
        # Dip with dip belt
        performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(59), exercise_type: Exercise.find(59).exercise_type)
        wss = WeightSetService.new(@user, @routine, performed_exercise)
        sets = wss.create_sets
        expect(sets.count).to eq(4)
        expect(performed_exercise.reload.rest_period).to eq(60)
        expect(sets[0].rec_weight).to eq(0)
        expect(sets[1].rec_weight).to eq(0)
        expect(sets[2].rec_weight).to eq(0)
        expect(sets[3].rec_weight).to eq(0)
        expect(sets[0].rec_reps).to eq(15)
        expect(sets[1].rec_reps).to eq(15)
        expect(sets[2].rec_reps).to eq(15)
        expect(sets[3].rec_reps).to eq(15)
      end

    end
  end

  context 'power lean' do

    it 'returns the right number of reps for male power exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)
    end

    it 'returns the right number of reps for male regular exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(15)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(10)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(15)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(12)
    end

    it 'returns the right number of reps for female power exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 125, sex: 'female', weight: 110, hor_pull_max: 130, knee_dom_max: 145)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)
    end

    it 'returns the right number of reps for female regular exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 125, sex: 'female', weight: 110, hor_pull_max: 130, knee_dom_max: 145)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 1, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(15)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(10)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(18)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(12)
    end
  end

  context 'power mass' do

    it 'returns the right number of reps for male power exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 2, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(3)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(4)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(3)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(4)
    end

    it 'returns the right number of reps for male regular exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 2, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(8)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(8)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(4)
    end

    it 'returns the right number of reps for female power exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 125, sex: 'female', weight: 110, hor_pull_max: 130, knee_dom_max: 145)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 2, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(4)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(4)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(4)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(4)
    end

    it 'returns the right number of reps for female regular exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 125, sex: 'female', weight: 110, hor_pull_max: 130, knee_dom_max: 145)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 2, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(8)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(10)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(8)
    end
  end

  context 'power rip' do

    it 'returns the right number of reps for male power exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 3, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(5)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(3)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(5)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(5)
      expect(sets[0].rec_reps).to eq(3)
    end

    it 'returns the right number of reps for male regular exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 165, sex: 'male', weight: 200, hor_pull_max: 200, knee_dom_max: 265)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 3, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(10)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(8)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)
    end

    it 'returns the right number of reps for female power exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 125, sex: 'female', weight: 110, hor_pull_max: 130, knee_dom_max: 145)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 3, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(5)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(6)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(1), exercise_type: Exercise.find(1).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(5)
    end

    it 'returns the right number of reps for female regular exercises' do
      @user = FactoryGirl.create(:user, hor_push_max: 125, sex: 'female', weight: 110, hor_pull_max: 130, knee_dom_max: 145)
      @user_schedule = UserSchedule.create_user_schedule({user_id: @user.id, program_type_id: 3, program_id: 1})
      @user_schedule.setup_phases
      @user_schedule.save!

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(10)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 22.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(15)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 43.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(8)

      @routine = FactoryGirl.create(:daily_routine, user: @user, day_performed: Date.today + 69.days)
      performed_exercise = PerformedExercise.new(daily_routine: @routine, exercise: Exercise.find(82), exercise_type: Exercise.find(82).exercise_type)
      wss = WeightSetService.new(@user, @routine, performed_exercise)
      sets = wss.create_sets
      expect(sets.count).to eq(4)
      expect(sets[0].rec_reps).to eq(12)
    end
  end

end