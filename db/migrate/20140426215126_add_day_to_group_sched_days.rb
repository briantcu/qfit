class AddDayToGroupSchedDays < ActiveRecord::Migration
  def change
    add_column :group_schedule_days, :day, :integer
  end
end
