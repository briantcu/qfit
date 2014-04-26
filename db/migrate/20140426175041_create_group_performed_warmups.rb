class CreateGroupPerformedWarmups < ActiveRecord::Migration
  def change
    create_table :group_performed_warmups do |t|
      t.integer :routine_id
      t.integer :warmup_id
      t.integer :status

      t.timestamps
    end
  end
end
