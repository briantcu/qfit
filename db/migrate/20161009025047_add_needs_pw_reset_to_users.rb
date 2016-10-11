class AddNeedsPwResetToUsers < ActiveRecord::Migration
  def change
    add_column :users, :needs_pw_reset, :boolean
  end
end
