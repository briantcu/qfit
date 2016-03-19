class AddSharedToRoutine < ActiveRecord::Migration
  def change
    add_column :daily_routines, :shared, :boolean, default: false
  end
end
