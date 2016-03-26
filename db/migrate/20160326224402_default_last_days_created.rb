class DefaultLastDaysCreated < ActiveRecord::Migration
  def change
    change_column_default(:users, :last_weight_day_created, 0)
    change_column_default(:users, :last_warmup_day_created, 0)
    change_column_default(:users, :last_plyometric_day_created, 0)
    change_column_default(:users, :last_sprint_day_created, 0)
    change_column_default(:groups, :last_wu_day_created, 0)
    change_column_default(:groups, :last_pl_day_created, 0)
    change_column_default(:groups, :last_sp_day_created, 0)
    change_column_default(:groups, :last_weight_day_created, 0)
  end
end
