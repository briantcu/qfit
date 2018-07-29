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
  has_many :sprint_details, through: :sprint

  def self.add_exercise(exercise_id, status, routine_id)
    GroupPerformedSprint.create(routine_id: routine_id, sprint_id: exercise_id, status: status)
  end

  def update_ex(params)
    if self.update(params)
      perf_sprints = get_user_exercises
      perf_sprints.each do |perf_sprint|
        perf_sprint.sync_with_group(self.sprint_id)
      end
      true
    else
      false
    end
  end

  def destroy_ex
    if status == 1
      get_user_exercises.each do |ex|
        ex.destroy
      end
      self.destroy
    else
      get_user_exes.each do |ex|
        ex.status = 2
        ex.save
      end
      self.status = 2
      self.save
    end

  end

  private

  def get_user_exercises
    PerformedSprint.where(group_performed_sprint_id: self.id)
  end
end
