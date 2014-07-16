class RenameExTypeInDayExercise < ActiveRecord::Migration
  change_table :day_exercises do |t|
    t.rename :ex_type, :exercise_type_id
  end
end
