# == Schema Information
#
# Table name: performed_sprints
#
#  id                        :integer          not null, primary key
#  sprint_id                 :integer
#  status                    :integer
#  group_performed_sprint_id :integer
#  routine_id                :integer
#  created_at                :datetime
#  updated_at                :datetime
#

class PerformedSprint < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id
  belongs_to :sprint
  belongs_to :group_performed_sprint, :foreign_key => :group_performed_sprint_id
  has_many :laps, -> { order('id ASC') }
  accepts_nested_attributes_for :laps, allow_destroy: true, reject_if: proc { |attributes| attributes['id'].blank? }

  def self.add_exercise(exercise_id, status, routine_id, group_performed_ex_id)
    PerformedSprint.create(routine_id: routine_id, sprint_id: exercise_id, status: status, group_performed_sprint_id: group_performed_ex_id)
  end
end
