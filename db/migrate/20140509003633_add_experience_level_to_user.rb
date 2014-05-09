class AddExperienceLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :experience_level, :integer
  end
end
