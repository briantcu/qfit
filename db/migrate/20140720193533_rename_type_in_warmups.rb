class RenameTypeInWarmups < ActiveRecord::Migration
  change_table :warmups do |t|
    t.rename :type, :ex_type
  end
end
