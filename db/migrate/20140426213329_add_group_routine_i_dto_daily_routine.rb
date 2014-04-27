class AddGroupRoutineIDtoDailyRoutine < ActiveRecord::Migration
  def change
    add_column :daily_routines, :group_routine_id, :integer
  end
end
