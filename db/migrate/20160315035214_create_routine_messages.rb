class CreateRoutineMessages < ActiveRecord::Migration
  def change
    create_table :routine_messages do |t|
      t.integer :daily_routine_id
      t.text :message

      t.timestamps
    end
  end
end
