class AddDiffToUserPoints < ActiveRecord::Migration
  def change
    add_column :user_points, :diff, :integer
  end
end
