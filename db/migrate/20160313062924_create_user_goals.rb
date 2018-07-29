class CreateUserGoals < ActiveRecord::Migration
  def change
    create_table :user_goals do |t|
      t.integer :user_id
      t.integer :goal_definition_id
      t.json :value

      t.timestamps
    end
  end
end
