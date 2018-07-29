class AddRoutineIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :routine_id, :integer
  end
end
