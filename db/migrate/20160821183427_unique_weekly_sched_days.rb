class UniqueWeeklySchedDays < ActiveRecord::Migration
  def change
    add_index :weekly_schedule_days, [:day, :user_schedule_id], unique: true
  end
end
