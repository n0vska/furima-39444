FactoryBot.define do
  factory :purchase_record do
    user
    item
    token {"sk_test_cccecbd471246f4255bf1856"}
  end
end
