class CreateSentCodes < ActiveRecord::Migration
  def change
    create_table :sent_codes do |t|
      t.string :code
      t.string :receiver
      t.boolean :used

      t.timestamps
    end
  end
end
