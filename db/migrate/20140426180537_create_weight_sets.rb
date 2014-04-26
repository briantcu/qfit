class CreateWeightSets < ActiveRecord::Migration
  def change
    create_table :weight_sets do |t|
      t.integer :set_num
      t.integer :performed_exercise_id
      t.float :rec_weight
      t.integer :rec_reps
      t.float :perf_weight
      t.integer :perf_reps

      t.timestamps
    end
  end
end
