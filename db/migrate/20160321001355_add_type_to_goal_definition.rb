class AddTypeToGoalDefinition < ActiveRecord::Migration
  def change
    add_column :goal_definitions, :goal_type, :integer
  end
end
