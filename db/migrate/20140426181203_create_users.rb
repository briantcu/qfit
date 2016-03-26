class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :master_user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :sex
      t.boolean :administrator
      t.boolean :sub_user
      t.float :knee_dom_max
      t.float :hor_push_max
      t.float :hor_pull_max
      t.integer :power_index
      t.string :password
      t.integer :current_phase
      t.string :phone
      t.integer :last_weight_day_created
      t.integer :last_warmup_day_created
      t.integer :last_plyometric_day_created
      t.integer :last_sprint_day_created
      t.string :user_name
      t.integer :sprint_diff, default: 1
      t.float :weight
      t.integer :level
      t.integer :program_type
      t.integer :birth_year
      t.date :subscription_date

      t.timestamps
    end
  end
end
