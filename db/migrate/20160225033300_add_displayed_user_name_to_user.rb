class AddDisplayedUserNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :displayed_user_name, :string
  end
end
