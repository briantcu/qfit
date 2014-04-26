class CreatePerformedExercises < ActiveRecord::Migration
  def change
    create_table :performed_exercises do |t|
      t.integer :routine_id
      t.integer :exercise_id
      t.integer :rest_period
      t.integer :status
      t.integer :one_rep_max
      t.integer :group_performed_exercise_id
      t.integer :exercise_type

      t.timestamps
    end
  end
end
