class RenamePassWordForUser < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :password, :old_password
  end
end
