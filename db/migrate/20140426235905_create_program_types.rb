class CreateProgramTypes < ActiveRecord::Migration
  def change
    create_table :program_types do |t|
      t.string :program_type

      t.timestamps
    end
  end
end
