class RenamePlyosForGroupSchedDays < ActiveRecord::Migration
  change_table :group_schedule_days do |t|
    t.rename :plyos, :plyometrics
  end
end
