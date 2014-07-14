class RenameTypeForCustomExercise < ActiveRecord::Migration
  change_table :custom_exercises do |t|
    t.rename :type, :ex_type
  end
end
