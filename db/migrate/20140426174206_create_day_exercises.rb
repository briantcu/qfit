class CreateDayExercises < ActiveRecord::Migration
  def change
    create_table :day_exercises do |t|
      t.integer :program_day_id
      t.integer :ex_type

      t.timestamps
    end
  end
end
