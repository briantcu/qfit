class AddTypetoWarmups < ActiveRecord::Migration
  def change
    add_column :warmups, :type, :integer
  end
end
