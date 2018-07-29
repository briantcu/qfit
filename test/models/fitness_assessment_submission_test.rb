require 'test_helper'

class FitnessAssessmentSubmissionTest < ActiveSupport::TestCase

  test 'processes submission correctly' do
    FactoryGirl.create(:user, id: 1)
    fitness_assessment_submission = FitnessAssessmentSubmission.new(:user_id => 1, :weight => 150, :bench_reps => 10,
      :bench_weight => 200, :squat_reps => 11, :squat_weight => 300, :push_ups => 30, :assisted_push_ups => 50,
      :experience_level => 3, :sex => 'male', :pull_ups => 30)

    OneRepMax.expects(:get_max).times(1).with(10, 200).returns(100)
    OneRepMax.expects(:get_max).times(1).with(30, 150).returns(200)
    OneRepMax.expects(:get_max).times(1).with(11, 300).returns(300)

    user = fitness_assessment_submission.process_submission

    assert(user.hor_push_max == 92)
    assert(user.hor_pull_max == 184)
    assert(user.knee_dom_max == 276)
    assert(user.weight == 150)
    assert(user.sex == 'male')
  end

  test 'processes submission using push ups only' do
    FactoryGirl.create(:user, id: 1)
    fitness_assessment_submission = FitnessAssessmentSubmission.new(:user_id => 1, :weight => 150, :bench_reps => 0,
                                                                    :bench_weight => 0, :squat_reps => 0, :squat_weight => 0,
                                                                    :push_ups => 30, :assisted_push_ups => 50,
                                                                    :experience_level => 1, :sex => 'male', :pull_ups => 0)

    OneRepMax.expects(:get_max).times(1).with(30, 45).returns(100)

    user = fitness_assessment_submission.process_submission

    assert(user.hor_push_max == 78)
    assert(user.hor_pull_max == 46)
    assert(user.knee_dom_max == 93)
    assert(user.weight == 150)
    assert(user.sex == 'male')
  end

end