class ChangeProTypeIdOnUserSched < ActiveRecord::Migration
  change_table :user_schedules do |t|
    t.rename :program_type, :program_type_id
  end
end
