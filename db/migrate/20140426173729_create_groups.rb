class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :coach_user_id
      t.string :name
      t.integer :current_phase
      t.integer :sprint_diff, default: 1
      t.integer :last_weight_day_created
      t.integer :last_wu_day_created
      t.integer :last_pl_day_created
      t.integer :last_sp_day_created
      t.boolean :shared

      t.timestamps
    end
  end
end
