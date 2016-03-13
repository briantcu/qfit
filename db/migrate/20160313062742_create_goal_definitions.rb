class CreateGoalDefinitions < ActiveRecord::Migration
  def change
    create_table :goal_definitions do |t|
      t.integer :order
      t.text :goal_text
      t.text :achieved_text
      t.integer :points

      t.timestamps
    end
  end
end
