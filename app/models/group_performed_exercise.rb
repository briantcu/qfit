# == Schema Information
#
# Table name: group_performed_exercises
#
#  id                    :integer          not null, primary key
#  performed_exercise_id :integer
#  routine_id            :integer
#  exercise_id           :integer
#  status                :integer
#  exercise_type         :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class GroupPerformedExercise < ActiveRecord::Base
end
