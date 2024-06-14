class Webhook::EndpointsController < ApplicationController
  def index
    render json: { message: "Event Accepted" }, status: 202
  end

  def create
    payload = request.body.read
    Rails.logger.info "Received payload: #{payload}"
    render json: { message: "Payload received" }, status: 200
  end
end
