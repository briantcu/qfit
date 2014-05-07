class CreateWorkoutScheduleSuggestions < ActiveRecord::Migration
  def change
    create_table :workout_schedule_suggestions do |t|
      t.integer :program_type
      t.integer :weight_schedule
      t.integer :program_id
      t.integer :num_weight_days
      t.integer :num_plyo_days
      t.integer :num_sprint_days

      t.timestamps
    end
  end
end
