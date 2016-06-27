class AddFbUserIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :string
  end
end
