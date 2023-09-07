class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category, class_name: 'Category'
  belongs_to :condition, class_name: 'Condition'
  belongs_to :prefecture, class_name: 'Prefecture'
  belongs_to :shipping_fee, class_name: 'ShippingFee'
  belongs_to :days_until_shipping, class_name: 'DaysUntilShipping'
  has_one_attached :image

  # Presence validations
  with_options presence: true do
    validates :image
    validates :description
    validates :category_id
    validates :condition_id
    validates :prefecture_id
    validates :shipping_fee_id
    validates :days_until_shipping_id
    
    # Price validations with numericality and format
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: /\A\d+\z/, message: "must be a half-width number" }
  end

  # Numericality validations for ActiveHash associations
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :prefecture_id
    validates :shipping_fee_id
    validates :days_until_shipping_id
  end
end
