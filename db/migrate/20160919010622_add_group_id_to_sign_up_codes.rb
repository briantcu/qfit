class AddGroupIdToSignUpCodes < ActiveRecord::Migration
  def change
    add_column :sign_up_codes, :group_id, :integer
  end
end
