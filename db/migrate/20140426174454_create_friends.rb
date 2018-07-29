class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :id_one
      t.integer :id_two

      t.timestamps
    end
  end
end
