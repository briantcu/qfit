class RemoveColumnGpe < ActiveRecord::Migration
  def change
    remove_column :group_performed_exercises, :performed_exercise_id
  end
end
