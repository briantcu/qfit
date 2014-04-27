class ChangeNamesOnCustomExercise < ActiveRecord::Migration
    change_table :custom_exercises do |t|
      t.rename :rid, :routine_id
      t.rename :gid, :group_id
    end
end
