class CreatePerformedSprints < ActiveRecord::Migration
  def change
    create_table :performed_sprints do |t|
      t.integer :sprint_id
      t.integer :status
      t.integer :group_performed_sprint_id
      t.integer :routine_id

      t.timestamps
    end
  end
end
