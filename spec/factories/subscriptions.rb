FactoryBot.define do
  factory :subscription do
    title { "MyString" }
    status { false }
    price { 1.5 }
    frequency { "MyString" }
    customer { nil }
    tea { nil }
  end
end
