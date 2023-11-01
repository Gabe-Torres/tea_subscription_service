FactoryBot.define do
  factory :subscription do
    title { Faker::Tea.type }
    status { true }
    price { Faker::Commerce.price }
    frequency { Faker::Subscription.payment_term }
    customer { nil }
    tea { nil }
  end
end
