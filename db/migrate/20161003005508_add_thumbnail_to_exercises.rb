class AddThumbnailToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :thumbnail, :string
  end
end
