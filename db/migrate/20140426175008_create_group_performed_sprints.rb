class CreateGroupPerformedSprints < ActiveRecord::Migration
  def change
    create_table :group_performed_sprints do |t|
      t.integer :sprint_id
      t.integer :status
      t.integer :routine_id

      t.timestamps
    end
  end
end
