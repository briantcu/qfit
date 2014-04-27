class ChangeNamesExercises < ActiveRecord::Migration
  change_table :exercises do |t|
    t.rename :type, :exercise_type_id
  end
end
