FactoryBot.define do
  factory :subscription do
    title { Faker::Tea.type }
    status { Faker::Subscription.status }
    price { Faker::Commerce.price }
    frequency { Faker::Subscription.payment_term }
    customer { nil }
    tea { nil }
  end
end
