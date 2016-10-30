class AddTokenToDailyRoutine < ActiveRecord::Migration
  def change
    add_column :daily_routines, :token, :string

    add_index :daily_routines, :token
  end
end
