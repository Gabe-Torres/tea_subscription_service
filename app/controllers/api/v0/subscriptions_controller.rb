class Api::V0::SubscriptionsController < ApplicationController
  def create
    begin
      subscription = Subscription.create!(subscription_params)
      render json: SubscriptionsSerializer.new(subscription), status: 201
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: 400
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render json: SubscriptionsSerializer.new(subscription), status: 200
  end

  private

  def subscription_params
    params.permit(:tea_id, :customer_id, :title, :price, :status, :frequency)
  end
end
