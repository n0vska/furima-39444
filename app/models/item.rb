class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category, class_name: 'Category'
  belongs_to :condition, class_name: 'Condition'
  belongs_to :prefecture, class_name: 'Prefecture'
  belongs_to :shipping_fee, class_name: 'ShippingFee'
  belongs_to :days_until_shipping, class_name: 'DaysUntilShipping'
  has_one_attached :image

  validates :category_id, 
            :condition_id, 
            :prefecture_id, 
            :shipping_fee_id, 
            :days_until_shipping_id, presence: true

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :prefecture_id
    validates :shipping_fee_id
    validates :days_until_shipping_id
  end
end
