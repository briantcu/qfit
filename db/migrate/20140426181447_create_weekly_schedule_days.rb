class CreateWeeklyScheduleDays < ActiveRecord::Migration
  def change
    create_table :weekly_schedule_days do |t|
      t.integer :day
      t.integer :user_schedule_id
      t.boolean :weights
      t.boolean :plyometrics
      t.boolean :stretching
      t.boolean :sprinting

      t.timestamps
    end
  end
end
