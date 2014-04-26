class CreateOneRepMaxes < ActiveRecord::Migration
  def change
    create_table :one_rep_maxes do |t|
      t.integer :rep
      t.float :percentage

      t.timestamps
    end
  end
end
