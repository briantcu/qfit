class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :value
      t.integer :type
      t.date :created

      t.timestamps
    end
  end
end
