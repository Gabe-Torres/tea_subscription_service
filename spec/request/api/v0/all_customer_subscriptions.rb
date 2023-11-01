require "rails_helper"

RSpec.describe "All Customer Subscriptions API", type: :request do
  before(:each) do
    @customer1 = create(:customer)
    @tea = create(:tea)
    @cancelled_subscription = create(:subscription, customer_id: @customer1.id, tea_id: @tea.id, status: true, price: 10.00, frequency: "monthly", title: "Special Tea")

    expect(@cancelled_subscription.status).to eq(true)
    patch "/api/v0/subscriptions/#{Subscription.first.id}", params: { status: false }
    updated_subscription = Subscription.find(Subscription.first.id)

    expect(updated_subscription.status).to eq(false)

    @tea2 = create(:tea)
    @active_subscription = create(:subscription, customer_id: @customer1.id, tea_id: @tea2.id, status: true, price: 20.00, frequency: "bi-monthly", title: "Not Special Tea")
  end
  describe "GET /subscriptions" do
    it "returns all active and cancelled subscriptions for a customer" do
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v0/subscriptions/#{Customer.first.id}/subscriptions", headers: headers

      all_subscriptions = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.status).to eq(200)
      expect(response.body).to be_a(String)
      expect(response.body).to include("data")
      expect(response.body).to include("type")
      expect(response.body).to include("id")
      expect(response.body).to include("attributes")
      expect(all_subscriptions[:data].count).to eq(2)
      expect(all_subscriptions[:data][0][:attributes][:status]).to eq(false)
      expect(all_subscriptions[:data][1][:attributes][:status]).to eq(true)
      expect(all_subscriptions[:data][0][:attributes][:title]).to eq("Special Tea")
      expect(all_subscriptions[:data][1][:attributes][:title]).to eq("Not Special Tea")
      expect(all_subscriptions[:data][0][:attributes][:frequency]).to eq("monthly")
      expect(all_subscriptions[:data][1][:attributes][:frequency]).to eq("bi-monthly")
      expect(all_subscriptions[:data][0][:attributes][:price]).to eq(10.00)
      expect(all_subscriptions[:data][1][:attributes][:price]).to eq(20.00)
      expect(all_subscriptions[:data][0][:attributes][:customer_id]).to eq(@customer1.id)
      expect(all_subscriptions[:data][1][:attributes][:customer_id]).to eq(@customer1.id)
    end
  end
end