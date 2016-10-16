class CreateSubscriptionEvents < ActiveRecord::Migration
  def change
    create_table :subscription_events do |t|
      t.integer :user_id
      t.string :subscription_id
      t.string :event
      t.string :stripe_event_id
      t.string :subscription_status

      t.timestamps null: false
    end
  end
end
