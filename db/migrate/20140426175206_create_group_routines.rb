class CreateGroupRoutines < ActiveRecord::Migration
  def change
    create_table :group_routines do |t|
      t.integer :group_id
      t.date :day_performed
      t.integer :program_day_id
      t.integer :wt_day_id
      t.integer :sp_day_id
      t.integer :pl_day_id
      t.integer :wu_day_id
      t.boolean :modified
      t.boolean :pl_modified
      t.boolean :wt_modified
      t.boolean :wu_modified
      t.boolean :sp_modified
      t.boolean :changes_saved

      t.timestamps
    end
  end
end
