class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.integer :male_power_sets
      t.integer :male_power_reps
      t.integer :male_other_sets
      t.integer :male_other_reps
      t.integer :fem_power_sets
      t.integer :fem_power_reps
      t.integer :fem_other_sets
      t.integer :fem_other_reps

      t.timestamps
    end
  end
end
