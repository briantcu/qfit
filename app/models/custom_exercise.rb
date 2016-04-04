class CustomExercise < ActiveRecord::Base
  belongs_to :daily_routine, :foreign_key => :routine_id, dependent: :destroy

  def self.add_exercise(routine_id, name, type_id, group_performed_id)
    CustomExercise.create(routine_id: routine_id, name: name, ex_type: type_id, group_id: group_performed_id)
  end
end
