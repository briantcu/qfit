class CreateGroupPerformedExercises < ActiveRecord::Migration
  def change
    create_table :group_performed_exercises do |t|
      t.integer :performed_exercise_id
      t.integer :routine_id
      t.integer :exercise_id
      t.integer :status
      t.integer :exercise_type

      t.timestamps
    end
  end
end
