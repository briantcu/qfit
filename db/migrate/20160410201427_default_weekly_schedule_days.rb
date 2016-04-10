class DefaultWeeklyScheduleDays < ActiveRecord::Migration
  def change
    change_column_default(:weekly_schedule_days, :stretching, false)
    change_column_default(:weekly_schedule_days, :plyometrics, false)
    change_column_default(:weekly_schedule_days, :sprinting, false)
    change_column_default(:weekly_schedule_days, :weights, false)
    change_column_default(:group_schedule_days, :weights, false)
    change_column_default(:group_schedule_days, :plyometrics, false)
    change_column_default(:group_schedule_days, :plyometrics, false)
    change_column_default(:group_schedule_days, :stretching, false)
  end
end
