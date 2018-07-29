class AddDefaultsToGroupRoutines < ActiveRecord::Migration
  def change
    change_column :group_routines, :modified, :boolean, default: false
    change_column :group_routines, :pl_modified, :boolean, default: false
    change_column :group_routines, :wu_modified, :boolean, default: false
    change_column :group_routines, :wt_modified, :boolean, default: false
    change_column :group_routines, :sp_modified, :boolean, default: false
  end
end
