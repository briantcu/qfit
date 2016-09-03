class AddActiveUntilToCoachAccounts < ActiveRecord::Migration
  def change
    add_column :coach_accounts, :active_until, :timestamp
  end
end
