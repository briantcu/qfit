class RenameExTypeGpe < ActiveRecord::Migration
  change_table :group_performed_exercises do |t|
    t.rename :exercise_type, :exercise_type_id
  end
end
