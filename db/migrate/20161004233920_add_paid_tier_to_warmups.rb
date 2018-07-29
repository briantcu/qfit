class AddPaidTierToWarmups < ActiveRecord::Migration
  def change
    add_column :warmups, :paid_tier, :integer
  end
end
