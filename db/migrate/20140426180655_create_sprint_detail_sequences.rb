class CreateSprintDetailSequences < ActiveRecord::Migration
  def change
    create_table :sprint_detail_sequences do |t|
      t.integer :sprint_id
      t.integer :detail_num
      t.integer :order_num

      t.timestamps
    end
  end
end
