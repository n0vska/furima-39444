class ShippingAddress < ApplicationRecord
  belongs_to :purchase_record

  validates :postal_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'は「3桁ハイフン4桁」の形式で入力してください' }
  validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
  validates :city, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以下の半角数字で入力してください' }
end