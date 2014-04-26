class CreatePerformedWarmUps < ActiveRecord::Migration
  def change
    create_table :performed_warm_ups do |t|
      t.integer :routine_id
      t.integer :warmup_id
      t.integer :status
      t.integer :group_warmup_id
      t.boolean :completed

      t.timestamps
    end
  end
end
