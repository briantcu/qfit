class CreateCoachAccounts < ActiveRecord::Migration
  def change
    create_table :coach_accounts do |t|
      t.integer :user_id
      t.integer :num_accts
      t.string :billing_email

      t.timestamps
    end
  end
end
