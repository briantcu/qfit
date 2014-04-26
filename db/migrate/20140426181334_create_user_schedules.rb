class CreateUserSchedules < ActiveRecord::Migration
  def change
    create_table :user_schedules do |t|
      t.integer :user_id
      t.integer :program_id
      t.integer :program_type
      t.date :phase_one_start
      t.date :phase_two_start
      t.date :phase_three_start
      t.date :phase_four_start
      t.date :sign_up_date

      t.timestamps
    end
  end
end
