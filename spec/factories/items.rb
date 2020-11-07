FactoryBot.define do
  factory :item do
    name { Faker::Team.name }
    description { Faker::Lorem.sentence }
    price { 999 }

    category_id { 3 }
    item_condition_id { 3 }
    prefecture_id { 3 }
    ship_date_id { 3 }
    shipping_cost_id { 3 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
