class AddNeedsPwResetToUsers < ActiveRecord::Migration
  def change
    change_column :users, :needs_pw_reset, :boolean, default: false
  end
end
