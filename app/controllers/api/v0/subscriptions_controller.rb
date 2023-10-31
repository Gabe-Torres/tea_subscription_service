class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create(subscription_params)
    render json: SubscriptionsSerializer.new(subscription), status: 201
  end

  private
  def subscription_params
    params.permit(:tea_id, :customer_id, :title, :price, :status, :frequency)
  end
end