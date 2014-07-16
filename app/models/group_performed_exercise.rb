# == Schema Information
#
# Table name: group_performed_exercises
#
#  id               :integer          not null, primary key
#  routine_id       :integer
#  exercise_id      :integer
#  status           :integer
#  exercise_type_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class GroupPerformedExercise < ActiveRecord::Base
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :exercise
  belongs_to :exercise_type

  def self.add_exercise(exercise_id, status, routine_id, exercise_type)
    GroupPerformedExercise.create(routine_id: routine_id, exercise_id: exercise_id, status: status, exercise_type_id: exercise_type)
  end
end
