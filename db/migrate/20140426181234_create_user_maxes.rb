class CreateUserMaxes < ActiveRecord::Migration
  def change
    create_table :user_maxes do |t|
      t.integer :exercise_id
      t.integer :user_id
      t.float :max

      t.timestamps
    end
  end
end
