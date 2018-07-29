class CreateGroupScheduleDays < ActiveRecord::Migration
  def change
    create_table :group_schedule_days do |t|
      t.integer :group_schedule_id
      t.boolean :weights
      t.boolean :plyos
      t.boolean :stretching
      t.boolean :sprinting

      t.timestamps
    end
  end
end
