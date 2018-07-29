class ChangeProTypeOnUser < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :program_type, :program_type_id
  end
end
