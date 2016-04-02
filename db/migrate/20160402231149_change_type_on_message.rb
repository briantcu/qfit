class ChangeTypeOnMessage < ActiveRecord::Migration
  change_table :messages do |t|
    t.rename :type, :message_type
  end
end
