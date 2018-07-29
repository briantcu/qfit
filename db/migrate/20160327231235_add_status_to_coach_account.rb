class AddStatusToCoachAccount < ActiveRecord::Migration
  def change
    add_column :coach_accounts, :active, :boolean, default: true
  end
end
