require "rails_helper"

RSpec.describe "Update Subscription API", type: :request do
  context "PATCH /subscriptions" do
    scenario "a customer can update their subscription" do
      customer1 = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, customer_id: customer1.id, tea_id: tea.id, status: true, price: 10.00, frequency: "monthly", title: "Special Tea")

      subscription_status = subscription.status

      expect(subscription_status).to eq(true)

      updated_subscription_params = { status: false }

      headers = { "CONTENT_TYPE" => "application/json" }

      patch "/api/v0/subscriptions/#{subscription.id}", headers: headers, params: updated_subscription_params.to_json

      return_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response).to have_http_status(:ok)
      expect(return_body[:data][:attributes][:status]).to eq(false)
    end
  end
end