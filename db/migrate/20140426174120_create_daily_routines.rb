class CreateDailyRoutines < ActiveRecord::Migration
  def change
    create_table :daily_routines do |t|
      t.integer :user_id
      t.integer :group_id
      t.date :day_performed
      t.integer :weight
      t.integer :power_index
      t.integer :count_ex_provided
      t.integer :count_ex_completed
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
      t.boolean :closed

      t.timestamps
    end
  end
end
