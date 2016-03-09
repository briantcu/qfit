require 'test_helper'

class PerformedExerciseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: performed_exercises
#
#  id                          :integer          not null, primary key
#  routine_id                  :integer
#  exercise_id                 :integer
#  rest_period                 :integer
#  status                      :integer
#  one_rep_max                 :integer
#  group_performed_exercise_id :integer
#  exercise_type_id            :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#
