class DefaultChangesSaved < ActiveRecord::Migration
  def change
    change_column_default(:daily_routines, :changes_saved, false)
    change_column_default(:group_routines, :changes_saved, false)
  end
end
