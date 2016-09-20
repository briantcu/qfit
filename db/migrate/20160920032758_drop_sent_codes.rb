class DropSentCodes < ActiveRecord::Migration
  def change
    drop_table :sent_codes
  end
end
