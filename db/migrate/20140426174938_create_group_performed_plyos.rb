class CreateGroupPerformedPlyos < ActiveRecord::Migration
  def change
    create_table :group_performed_plyos do |t|
      t.integer :plyometric_id
      t.integer :routine_id
      t.integer :status

      t.timestamps
    end
  end
end
