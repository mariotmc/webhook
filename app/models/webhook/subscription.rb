class Webhook::Subscription < ApplicationRecord
  self.table_name = "webhook_subscriptions"

  validates :receiver_url, presence: true, format: { with: URI::regexp(%w[http https]) }
  validates :topic, presence: true
  validates :customer_id, presence: true, numericality: { only_integer: true }
end
