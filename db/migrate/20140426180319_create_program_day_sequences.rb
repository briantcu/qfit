class CreateProgramDaySequences < ActiveRecord::Migration
  def change
    create_table :program_day_sequences do |t|
      t.integer :program_id
      t.integer :number_of_days
      t.integer :one
      t.integer :two
      t.integer :three
      t.integer :four
      t.integer :five
      t.integer :six
      t.integer :seven
      t.integer :eight
      t.integer :nine
      t.integer :ten

      t.timestamps
    end
  end
end
