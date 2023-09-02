class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :prefecture
  belongs_to :shipping_fee
  belongs_to :days_until_shipping
  has_one_attached :image

  validates :item_category_id, :item_condition_id, :prefecture_id, :shipping_fee_id, :days_until_shipping_id, presence: true

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :item_category_id
    validates :item_condition_id
    validates :prefecture_id
    validates :shipping_fee_id
    validates :days_until_shipping_id
  end
end
