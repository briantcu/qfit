class ChangeLeaderTypeName < ActiveRecord::Migration
  change_table :leaders do |t|
    t.rename :type, :leader_type
  end
end
