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
#  exercise_type               :integer
#  created_at                  :datetime
#  updated_at                  :datetime
#

class PerformedExercise < ActiveRecord::Base
end
