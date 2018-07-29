class CreateSignUpCodes < ActiveRecord::Migration
  def change
    create_table :sign_up_codes do |t|
      t.string :code
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
