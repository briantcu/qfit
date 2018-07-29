class AddFieldsToSignUpCodes < ActiveRecord::Migration
  def change
    add_column :sign_up_codes, :sign_up_type, :string
    add_column :sign_up_codes, :sent_to, :string
    add_column :sign_up_codes, :sent_to_type, :string
    add_column :sign_up_codes, :used, :boolean, default: false
  end
end
