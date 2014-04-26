class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :type
      t.string :video_link
      t.integer :look_up_value
      t.float :percent_of_luv
      t.integer :category
      t.integer :difficulty
      t.boolean :is_body_weight
      t.string :name
      t.boolean :is_image

      t.timestamps
    end
  end
end
