class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :poster_id
      t.text :message
      t.integer :parent_id
      t.integer :to_id
      t.integer :type

      t.timestamps
    end
  end
end
