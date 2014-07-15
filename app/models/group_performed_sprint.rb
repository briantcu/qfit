# == Schema Information
#
# Table name: group_performed_sprints
#
#  id         :integer          not null, primary key
#  sprint_id  :integer
#  status     :integer
#  routine_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupPerformedSprint < ActiveRecord::Base
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :sprint

  def self.add_exercise(exercise_id, status, routine_id)
    GroupPerformedSprint.create(routine_id: routine_id, sprint_id: exercise_id, status: status)
  end
end
