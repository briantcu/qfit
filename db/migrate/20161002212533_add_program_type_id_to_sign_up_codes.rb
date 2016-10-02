class AddProgramTypeIdToSignUpCodes < ActiveRecord::Migration
  def change
    add_column :sign_up_codes, :program_type_id, :integer
  end
end
