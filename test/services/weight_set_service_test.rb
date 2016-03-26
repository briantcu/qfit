require 'test_helper'

class WeightSetServiceTest < ActiveSupport::TestCase

  test 'should create sets for exception exercise' do
    user = User.find(1)
    date = Date.new(2014, 4, 26)
    routine = DailyRoutine.new(day_performed: date)
    perf_ex = PerformedExercise.find(1)
    wss = WeightSetService.new(user, routine, perf_ex)
    ProgramPhaseLookup.expects(:get_phase_id).times(1).returns(1)
    sets = wss.create_sets
    assert(sets.count == 5)
    assert(sets.at(1).rec_weight == 0)
  end

  test 'should create sets for med ball' do
    user = User.find(1)
    date = Date.new(2014, 4, 26)
    routine = DailyRoutine.new(day_performed: date)
    perf_ex = PerformedExercise.find(3)
    wss = WeightSetService.new(user, routine, perf_ex)
    ProgramPhaseLookup.expects(:get_phase_id).times(1).returns(1)
    sets = wss.create_sets
    assert(sets.count == 4)
    assert(sets.at(1).rec_weight == 6)
  end

  test 'should create sets for assisted body weight exercise' do
    user = User.find(1)
    date = Date.new(2014, 4, 26)
    routine = DailyRoutine.new(day_performed: date)
    perf_ex = PerformedExercise.find(4)
    wss = WeightSetService.new(user, routine, perf_ex)
    ProgramPhaseLookup.expects(:get_phase_id).times(1).returns(1)
    sets = wss.create_sets
    assert(sets.count == 4)
    assert(sets.at(1).rec_weight == 0)
  end

  test 'should create sets for belted body weight exercise' do
    user = User.find(1)
    date = Date.new(2014, 4, 26)
    routine = DailyRoutine.new(day_performed: date)
    perf_ex = PerformedExercise.find(5)
    wss = WeightSetService.new(user, routine, perf_ex)
    ProgramPhaseLookup.expects(:get_phase_id).times(1).returns(1)
    sets = wss.create_sets
    assert(sets.count == 4)
    assert(sets.at(1).rec_weight != 0)
  end

  test 'should create sets for single plate exercise' do
    user = User.find(1)
    date = Date.new(2014, 4, 26)
    routine = DailyRoutine.new(day_performed: date)
    perf_ex = PerformedExercise.find(6)
    wss = WeightSetService.new(user, routine, perf_ex)
    ProgramPhaseLookup.expects(:get_phase_id).times(1).returns(1)
    sets = wss.create_sets
    assert(sets.count == 4)
    assert(sets.at(1).rec_weight == 45)
  end

  test 'should create sets using existing user max' do
    user = User.find(1)
    date = Date.new(2014, 4, 26)
    routine = DailyRoutine.new(day_performed: date)
    perf_ex = PerformedExercise.find(7)
    wss = WeightSetService.new(user, routine, perf_ex)
    ProgramPhaseLookup.expects(:get_phase_id).times(1).returns(1)
    sets = wss.create_sets
    assert(sets.count == 4)
    assert(sets.at(1).rec_weight != 0)
  end

end