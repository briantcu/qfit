class AddDummyColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dummyone, :string
    add_column :users, :dummytwo, :string
    add_column :users, :dummythree, :string
    add_column :users, :dummyfour, :string
    add_column :users, :dummyfive, :string
    add_column :users, :dummysix, :string
    add_column :users, :dummyseven, :string
    add_column :users, :dummyeight, :string
    add_column :users, :dummynine, :string
    add_column :users, :dummyten, :string
    add_column :users, :dummyeleven, :string
    add_column :users, :dummytwelve, :string
    add_column :users, :dummythirteen, :string
    add_column :users, :dummyfourteen, :string
  end
end
