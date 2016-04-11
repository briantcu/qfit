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

class WeightSet < ActiveRecord::Base
  belongs_to :performed_exercise
end
