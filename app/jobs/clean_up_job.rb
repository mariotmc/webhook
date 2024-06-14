require "net/http"

class CleanUpJob < ApplicationJob
  queue_as :default

  retry_on Net::OpenTimeout, Net::ReadTimeout, wait: 5.seconds, attempts: 3

  def perform(subscription)
    subscription = Webhook::Subscription.find(subscription.id)

    return unless subscription

    event_history = EventHistory.create(
      customer_id: subscription.customer_id,
      topic: subscription.topic,
      delivery_status: "delivering"
    )

    begin
      response = Net::HTTP.get_response(URI(subscription.receiver_url))

      if response.is_a?(Net::HTTPSuccess)
        event_history.update(delivery_status: "delivered")
      else
        event_history.update(delivery_status: "not_delivered")
      end
    rescue StandardError => e
      event_history.update(delivery_status: "failed") if event_history
      Rails.logger.error("Failed to deliver webhook: #{e.message}")
    end
  end
end
