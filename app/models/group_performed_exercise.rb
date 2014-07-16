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
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :exercise

  def self.add_exercise(exercise_id, status, routine_id, exercise_type)
    GroupPerformedExercise.create(routine_id: routine_id, performed_exercise_id: exercise_id, status: status, exercise_type: exercise_type)
  end
end
