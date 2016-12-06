class DropUsersColumns < ActiveRecord::Migration
  def change
    remove_column :users, :dummyone
    remove_column :users, :dummytwo
    remove_column :users, :dummythree
    remove_column :users, :dummyfour
    remove_column :users, :dummyfive
    remove_column :users, :dummysix
    remove_column :users, :dummyseven
    remove_column :users, :dummyeight
    remove_column :users, :dummynine
    remove_column :users, :dummyten
    remove_column :users, :dummyeleven
    remove_column :users, :dummytwelve
    remove_column :users, :dummythirteen
    remove_column :users, :dummyfourteen
  end
end
