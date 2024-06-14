class Webhook::SubscriptionsController < ApplicationController
  before_action :authenticate, only: [:create, :index]

  def create
    subscription = Webhook::Subscription.new(subscription_params)

    if subscription.save
      render json: { message: "Subscription created successfully" }, status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    subscription = Webhook::Subscription.new(subscription_params)

    if subscription.save
      CleanUpJob.perform_later(subscription)
      render json: { message: "Subscription created and job initiated successfully" }, status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def subscription_params
      params.permit(:receiver_url, :topic, :customer_id)
    end

    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        credentials = Rails.application.credentials.dig(:webhook_auth)
        username == credentials[:username] && password == credentials[:password]
      end
    end
end
