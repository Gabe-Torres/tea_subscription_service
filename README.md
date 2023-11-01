<div align="center">
<h1> Tea Subscription Service </h1>

Technologies used:<br>
![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
</div>

A strictly backend api service that allows a frontend team to send and receive data for a tea subscription service. Customers will be able to subscribe to tea subscriptions, cancel subscriptions and have multiple subscriptions at once.

<details>
<summary>Author</summary>

### BE Team
- Gabe Torres [GitHub](https://github.com/Gabe-Torres) | [LinkedIn](https://www.linkedin.com/in/gabe-torres-74a515269/)
</details>

----

## Summary 
- [Getting Started](#getting-started)
- [Endpoints](#endpoints)
- [API JSON Contract](#api-json-contract)
- [Routes](#routes)
- [Schema Design](#schema_design)
- [Test Suite](#test-suite)

## Getting Started
<details>
<summary>Database Information</summary>

**Schema**

```ruby
ActiveRecord::Schema[7.0].define(version: 2023_10_31_161815) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "title"
    t.boolean "status"
    t.float "price"
    t.string "frequency"
    t.bigint "customer_id", null: false
    t.bigint "tea_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
    t.index ["tea_id"], name: "index_subscriptions_on_tea_id"
  end

  create_table "teas", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "temperature"
    t.string "brew_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "teas"
end
```

**Gems**
```ruby
gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem 'jsonapi-serializer'
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem 'capybara'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "factory_bot_rails"
  gem "faker"
  gem 'launchy'
  gem "pry"
  gem "rspec-rails"
  gem 'shoulda-matchers'
  gem 'simplecov'
end
```

 **Installing**
 - Fork and clone this repo
  - Run `bundle install`
  - Run `rails db:{create,migrate,seed}`
  - Run `rails s` to start the server
  - Open your browser and navigate to `localhost:3000`
</details>


## API JSON Contract
*Description of API endpoints for front end application*

<details>
<summary>Subscriptions</summary>

- Description of a customer subscribing

> `POST /api/v0/subscriptions`

*Request Body:*

```json
{
  "tea_id": 1,
  "customer_id": 1,
  "status": true,
  "price": 10.00,
  "frequency": "monthly",
  "title": "Special Tea"
}
```

*Success Response (200 OK):*
- Status: 200 OK
- Description: Successful response with a subscription object
- Data Format: A hash containing the subscription object. Has an id, type, and attributes. The attributes contain the subscription's title, price, frequency, status, customer_id, and tea_id.

*Return*

```json
{
  "data": {
    "id": "1",
    "type": "subscription",
    "attributes": {
      "title": "Special Tea",
      "price": 10.00,
      "status": true,
      "frequency": "monthly",
      "customer_id": 1,
      "tea_id": 1
    }
  }
}
```
---
*Error Response (400):*

- Status: 400 Bad Request
- Description: An error response indicating that the request was invalid.
- Data Format: A hash of that contains the key "errors" and a message describing the error in detail.

*Request Body:*
```json
 {
  "tea_id": "",
  "customer_id": "",
  "status": true,
  "price": 10.00,
  "frequency": "monthly",
  "title": "Special Tea"
}
```

*Return*
```json
{
  "error": "Validation failed: Customer must exist, Tea must exist"
}
```
</details>

<details>
<summary>cancel a subscription</summary>

- Description of canceling a subscription

> `PATCH /api/v0/subscriptions/:id`

*Request Body:*

```json
{
  "status": false
}
```

*Success Response (200 OK):*
- Status: 200 OK
- Description: Successful response with a updated subscription object
- Data Format: A hash containing a subscription object, containing an id, type, and attributes. The attributes contain the subscription's title, price, frequency, status, customer_id, and tea_id.

*Return*

```json
{
  "data": {
    "id": "1",
    "type": "subscriptions",
    "attributes": {
      "title": "Special Tea",
      "price": 10.00,
      "status": false,
      "frequency": "monthly",
      "customer_id": 1,
      "tea_id": 1
    }
  }
}
```

---
*Error Response (400):*

- Status: 400 Bad Request
- Description: An error response indicating that the request was invalid as the subscription was not found.
- Data Format: A hash of that contains the key "error" and a message describing the error in detail.

*Request Body:*
```json
 {
  "status": false
}
```

*Return*
```json
{
  "error": "Couldn't find Subscription with 'id'=1"
}
```
</details>

<details>
<summary>get all subscriptions</summary>

- Description of getting all a customers subscriptions

> `GET /api/v0/customers/:id/subscriptions`

*Request Body:*

```json
{
  "id": 1
}
```

*Success Response (200 OK):*
- Status: 200 OK
- Description: Successful response for receiving all subscriptions for a customer
- Data Format: A hash containing an array of subscription objects, containing an id, type, and attributes. The attributes contain each subscription's title, price, frequency, status, customer_id, and tea_id.

*Return*
```ruby
{
    "data": [
        {
            "id": "1",
            "type": "subscriptions",
            "attributes": {
                "title": "Oolong",
                "price": 93.07,
                "status": true,
                "frequency": "Full subscription",
                "customer_id": 1,
                "tea_id": 1
            }
        },
        {
            "id": "2",
            "type": "subscriptions",
            "attributes": {
                "title": "Oolong",
                "price": 53.87,
                "status": true,
                "frequency": "Monthly",
                "customer_id": 1,
                "tea_id": 2
            }
        },
        {
            "id": "3",
            "type": "subscriptions",
            "attributes": {
                "title": "Black",
                "price": 50.31,
                "status": true,
                "frequency": "Annual",
                "customer_id": 1,
                "tea_id": 3
            }
        },
        {
            "id": "4",
            "type": "subscriptions",
            "attributes": {
                "title": "White",
                "price": 16.15,
                "status": true,
                "frequency": "Full subscription",
                "customer_id": 1,
                "tea_id": 4
            }
        },
        {
            "id": "5",
            "type": "subscriptions",
            "attributes": {
                "title": "Herbal",
                "price": 27.4,
                "status": true,
                "frequency": "Full subscription",
                "customer_id": 1,
                "tea_id": 5
            }
        },
        {
            "id": "6",
            "type": "subscriptions",
            "attributes": {
                "title": "Herbal",
                "price": 2.84,
                "status": true,
                "frequency": "Annual",
                "customer_id": 1,
                "tea_id": 6
            }
        },
        {
            "id": "7",
            "type": "subscriptions",
            "attributes": {
                "title": "White",
                "price": 5.96,
                "status": true,
                "frequency": "Monthly",
                "customer_id": 1,
                "tea_id": 7
            }
        },
        {
            "id": "8",
            "type": "subscriptions",
            "attributes": {
                "title": "White",
                "price": 5.54,
                "status": true,
                "frequency": "Payment in advance",
                "customer_id": 1,
                "tea_id": 8
            }
        },
        {
            "id": "9",
            "type": "subscriptions",
            "attributes": {
                "title": "Herbal",
                "price": 71.87,
                "status": true,
                "frequency": "Payment in advance",
                "customer_id": 1,
                "tea_id": 9
            }
        },
        {
            "id": "10",
            "type": "subscriptions",
            "attributes": {
                "title": "Black",
                "price": 55.27,
                "status": true,
                "frequency": "Monthly",
                "customer_id": 1,
                "tea_id": 10
            }
        },
        {
            "id": "71",
            "type": "subscriptions",
            "attributes": {
                "title": "Special Tea",
                "price": 10.0,
                "status": false,
                "frequency": "monthly",
                "customer_id": 1,
                "tea_id": 1
            }
        }
    ]
}
```

---
*Error Response (400):*

- Status: 400 Bad Request
- Description: An error response indicating that the request was invalid as a customer was not found.
- Data Format: A hash of that contains the key "error" and a message describing the error in detail.
*Request Body:*
```json
 {
  "id": 555
}
```

*Response*
```ruby
{
    "error": "Couldn't find Customer with 'id'=555"
}
```
</details>

## Routes
| Action | Route |
| ----------- | ----------- |
| post | '/api/v0/subscriptions' |
| patch | '/api/v0/subscriptions/:id' |
| get | '/api/v0/customers/:id/subscriptions' |

## Schema Design
![Schema](/tmp/storage/tea-subscription-service.png)

## Test Suite
 - run `bundle exec rspec` to run the test suite

<details>
<summary>Happy Path</summary>
  
```ruby
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

      new_subscription_status = Subscription.find(subscription.id).status
      return_body = JSON.parse(response.body, symbolize_names: true)
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response).to have_http_status(:ok)
      expect(return_body[:data][:attributes][:status]).to eq(false)
      expect(new_subscription_status).to eq(false)
    end
  end
end
```
</details>

<details>
<summary>Sad Path</summary>
  
```ruby
require "rails_helper"

RSpec.describe "All Customer Subscriptions API", type: :request do
  context "GET /subscriptions sad path" do
    scenario "returns an error if customer does not exist" do
      headers = { "CONTENT_TYPE" => "application/json" }
      get "/api/v0/subscriptions/#{123456789}/subscriptions", headers: headers

      error_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:bad_request)
      expect(response.status).to eq(400)
      expect(error_response[:error]).to eq("Couldn't find Customer with 'id'=123456789")
    end
  end
end
```
</details>
