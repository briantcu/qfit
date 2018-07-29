class RenameTypeForGroupCustomExercise < ActiveRecord::Migration
  change_table :group_custom_exercises do |t|
    t.rename :type, :ex_type
  end
end
