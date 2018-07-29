class ChangeSprintDiffDefault < ActiveRecord::Migration
  def change
    change_column_default(:users, :sprint_diff, 1)
    change_column_default(:groups, :sprint_diff, 1)
  end
end
