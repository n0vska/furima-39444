class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :prefecture
  belongs_to :shipping_fee_burden
  belongs_to :days_until_shipping
  has_one_attached :image

  validates :item_category, presence: true
  validates :item_condition, presence: true
  validates :prefecture, presence: true
  validates :shipping_fee_burden, presence: true
  validates :days_until_shipping, presence: true

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :item_category_id
    validates :item_condition_id
    validates :prefecture_id
    validates :shipping_fee_burden_id
    validates :days_until_shipping_id
  end
end
