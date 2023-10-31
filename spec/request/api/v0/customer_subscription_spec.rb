require "rails_helper"

RSpec.describe "Customer Subscription API", type: :request do
  context "GET /subscriptions" do
    scenario "a customer can subscribe to a plan" do
      customer1 = create(:customer)
      tea = create(:tea)

      subscription_params = {
        tea_id: tea.id,
        customer_id: customer1.id,
        status: true,
        price: 10.00,
        frequency: "monthly",
        title: "Special Tea"
      }

      subscription1 = Subscription.create(subscription_params)

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v0/subscriptions", headers: headers, params: subscription_params.to_json

      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.status).to eq(201)
      expect(response.body).to be_a(String)
      expect(response.body).to include("data")
      expect(response.body).to include("type")
      expect(response.body).to include("id")
      expect(response.body).to include("attributes")
      expect(subscription1.customer_id).to eq(customer1.id)
      expect(subscription1.tea_id).to eq(tea.id)
      expect(subscription1.status).to eq(true)
      expect(subscription1.price).to eq(10.00)
      expect(subscription1.frequency).to eq("monthly")
      expect(subscription1.title).to eq("Special Tea")
    end
  end
end