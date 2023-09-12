# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    name { "テスト商品" }
    description { "これはテスト商品です" }
    category_id { 2 }  # "メンズ"
    condition_id { 2 }    # "新品・未使用"
    shipping_fee_id { 2 } # "着払い(購入者負担)"
    prefecture_id { 13 } # 東京都
    days_until_shipping_id { 2 } # "1~2日で発送"
    price { 500 }
    user
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_image.jpg')), filename: 'dummy_image.jpg')
    end
  end
end
