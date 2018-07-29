class CreateCustomExercises < ActiveRecord::Migration
  def change
    create_table :custom_exercises do |t|
      t.integer :rid
      t.string :details
      t.integer :status
      t.integer :gid
      t.string :name
      t.integer :type

      t.timestamps
    end
  end
end
