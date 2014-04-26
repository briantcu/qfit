class CreateSprintDetails < ActiveRecord::Migration
  def change
    create_table :sprint_details do |t|
      t.text :detail

      t.timestamps
    end
  end
end
