class AddDefaultsToDailyRoutines < ActiveRecord::Migration
  def change
    change_column :daily_routines, :closed, :boolean, default: false
    change_column :daily_routines, :modified, :boolean, default: false
    change_column :daily_routines, :pl_modified, :boolean, default: false
    change_column :daily_routines, :wu_modified, :boolean, default: false
    change_column :daily_routines, :wt_modified, :boolean, default: false
    change_column :daily_routines, :sp_modified, :boolean, default: false
  end
end
