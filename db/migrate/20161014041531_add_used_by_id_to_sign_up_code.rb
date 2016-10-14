class AddUsedByIdToSignUpCode < ActiveRecord::Migration
  def change
    add_column :sign_up_codes, :used_by_id, :integer
  end
end
