class DropAvatarsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avatars
  end
end
