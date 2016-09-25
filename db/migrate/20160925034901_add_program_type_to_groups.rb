class AddProgramTypeToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :program_type, :integer
  end
end
