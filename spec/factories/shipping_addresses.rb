FactoryBot.define do
  factory :shipping_address do
    postal_code { "123-4567" }
    prefecture_id { 1 }
    city { "Kanazawa" }
    street_address { "1-1-1" }
    building_name { "Building" }
    phone_number { "09012345678" }
  end
end