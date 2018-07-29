class AddPaidTierToExercise < ActiveRecord::Migration
  def change
    add_column :exercises, :paid_tier, :integer, default: 1
  end
end
