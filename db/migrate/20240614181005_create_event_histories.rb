class CreateEventHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :event_histories do |t|
      t.integer :customer_id
      t.string :topic
      t.string :delivery_status
      t.timestamps
    end
  end
end
