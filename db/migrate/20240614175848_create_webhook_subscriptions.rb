class CreateWebhookSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :webhook_subscriptions do |t|
      t.integer :customer_id
      t.string :receiver_url
      t.string :topic
      t.timestamps
    end
  end
end
