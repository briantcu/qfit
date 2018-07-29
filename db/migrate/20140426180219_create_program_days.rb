class CreateProgramDays < ActiveRecord::Migration
  def change
    create_table :program_days do |t|
      t.string :day_enumeration

      t.timestamps
    end
  end
end
