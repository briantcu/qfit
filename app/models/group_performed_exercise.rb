class GroupPerformedExercise < ActiveRecord::Base
  belongs_to :group_routine, :foreign_key => :routine_id
  belongs_to :exercise
  belongs_to :exercise_type

  def self.add_exercise(exercise_id, status, routine_id, exercise_type)
    GroupPerformedExercise.create(routine_id: routine_id, exercise_id: exercise_id, status: status, exercise_type_id: exercise_type)
  end

  def update_ex(params)
    if self.update(params)
      perf_exes = get_all_user_exercises
      perf_exes.each do |perf_ex|
        perf_ex.sync_with_group(self.exercise_id)
      end
      true
    else
      false
    end
  end

  def destroy_ex
    get_all_user_exercises.each do |ex|
      ex.destroy
    end
    self.destroy
  end

  private

  def get_all_user_exercises
    PerformedExercise.where(group_performed_exercise_id: self.id)
  end

end
