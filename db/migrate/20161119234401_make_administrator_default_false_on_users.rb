class MakeAdministratorDefaultFalseOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :administrator, :boolean, default: false
  end
end
