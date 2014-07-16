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
  belongs_to :daily_routine, :foreign_key => :routine_id
  belongs_to :group_performed_exercise
  belongs_to :exercise_type, :foreign_key => :exercise_type
  belongs_to :exercise
  has_many :weight_sets, -> { order('set_num ASC') }
  accepts_nested_attributes_for :weight_sets, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }

  def self.add_exercise(exercise_id, status, routine_id, exercise_type, group_exercise_id)
    GroupPerformedExercise.create(routine_id: routine_id, performed_exercise_id: exercise_id, status: status, exercise_type: exercise_type, group_performed_exercise_id: group_exercise_id)
  end
end
