require 'test_helper'

class WeightSetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: weight_sets
#
#  id                    :integer          not null, primary key
#  set_num               :integer
#  performed_exercise_id :integer
#  rec_weight            :float
#  rec_reps              :integer
#  perf_weight           :float
#  perf_reps             :integer
#  created_at            :datetime
#  updated_at            :datetime
#
