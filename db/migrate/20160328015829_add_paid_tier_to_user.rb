class AddPaidTierToUser < ActiveRecord::Migration
  def change
    add_column :users, :paid_tier, :integer, default: 1
  end
end
