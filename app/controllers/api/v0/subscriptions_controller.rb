class Api::V0::SubscriptionsController < ApplicationController
  def index
    begin
      customer = Customer.find(params[:id])
      customer_subscriptions = customer.subscriptions
      render json: SubscriptionsSerializer.new(customer_subscriptions), status: 200
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: 400
    end
  end

  def create
    begin
      subscription = Subscription.create!(subscription_params)
      render json: SubscriptionsSerializer.new(subscription), status: 201
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 400
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
      subscription.update!(status: params[:status])
      render json: SubscriptionsSerializer.new(subscription), status: 200
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: 400
    end
  end

  private

  def subscription_params
    params.permit(:tea_id, :customer_id, :title, :price, :status, :frequency)
  end
end
