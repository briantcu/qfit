class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.integer :difficulty
      t.string :name
      t.integer :sprint_type
      t.integer :num_laps

      t.timestamps
    end
  end
end
