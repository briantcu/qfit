class CreateProgramPhaseLookups < ActiveRecord::Migration
  def change
    create_table :program_phase_lookups do |t|
      t.integer :phase_number
      t.integer :program_type
      t.integer :phase_id

      t.timestamps
    end
  end
end
