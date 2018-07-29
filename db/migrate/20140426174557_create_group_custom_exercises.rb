class CreateGroupCustomExercises < ActiveRecord::Migration
  def change
    create_table :group_custom_exercises do |t|
      t.integer :routine_id
      t.text :details
      t.integer :status
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
