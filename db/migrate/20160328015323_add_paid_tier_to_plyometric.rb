class AddPaidTierToPlyometric < ActiveRecord::Migration
  def change
    add_column :plyometrics, :paid_tier, :integer, default: 1
  end
end
