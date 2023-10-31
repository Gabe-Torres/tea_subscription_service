FactoryBot.define do
  factory :customer do
    first_name { Faker::JapaneseMedia::DragonBall.character }
    last_name { Faker::Games::ElderScrolls.last_name }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
  end
end
