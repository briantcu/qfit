class AddForTimeToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :for_time, :boolean
  end
end
