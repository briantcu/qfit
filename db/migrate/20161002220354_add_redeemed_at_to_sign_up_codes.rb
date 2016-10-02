class AddRedeemedAtToSignUpCodes < ActiveRecord::Migration
  def change
    add_column :sign_up_codes, :redeemed_at, :datetime
  end
end
