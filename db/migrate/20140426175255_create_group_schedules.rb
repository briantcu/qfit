class CreateGroupSchedules < ActiveRecord::Migration
  def change
    create_table :group_schedules do |t|
      t.integer :group_id
      t.integer :program_id
      t.date :phase_one_start
      t.date :phase_two_start
      t.date :phase_three_start
      t.date :phase_four_start

      t.timestamps
    end
  end
end
