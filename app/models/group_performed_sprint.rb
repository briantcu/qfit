class GroupPerformedSprint < ActiveRecord::Base
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :sprint

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
    get_user_exercises.each do |ex|
      ex.destroy
    end
    self.destroy
  end

  private

  def get_user_exercises
    PerformedSprint.where(group_performed_sprint_id: self.id)
  end
end
