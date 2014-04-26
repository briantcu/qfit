class CreateLaps < ActiveRecord::Migration
  def change
    create_table :laps do |t|
      t.integer :lap_number
      t.integer :performed_sprint_id
      t.boolean :completed

      t.timestamps
    end
  end
end
