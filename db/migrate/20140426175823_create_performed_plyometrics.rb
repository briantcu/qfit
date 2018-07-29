class CreatePerformedPlyometrics < ActiveRecord::Migration
  def change
    create_table :performed_plyometrics do |t|
      t.integer :plyometric_id
      t.integer :routine_id
      t.integer :status
      t.integer :group_performed_plyometric_id
      t.boolean :performed_one
      t.boolean :performed_two
      t.boolean :performed_three

      t.timestamps
    end
  end
end
