class CreateGroupJoins < ActiveRecord::Migration
  def change
    create_table :group_joins do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end
  end
end
