class RemoveDisplayedUserName < ActiveRecord::Migration
  def change
    remove_column :users, :displayed_user_name
    remove_column :users, :old_password
  end
end
