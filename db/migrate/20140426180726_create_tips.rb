class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :exercise_type
      t.text :tip
      t.integer :exercise_id

      t.timestamps
    end
  end
end
