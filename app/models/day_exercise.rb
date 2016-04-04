class DayExercise < ActiveRecord::Base
  belongs_to :program_day
  belongs_to :exercise_type

  def self.get_exercises_for_day(program_day_id)
    DayExercise.where(:program_day_id => program_day_id).order(id: :asc)
  end
end
