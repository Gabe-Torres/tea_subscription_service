FactoryBot.define do
  factory :tea do
    name { Faker::Tea.variety }
    description { Faker::Coffee.notes }
    temperature { "100 F" }
    brew_time { "4 minutes" }
  end
end
