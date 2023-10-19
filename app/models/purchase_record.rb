class PurchaseRecord < ApplicationRecord
  has_one :shipping_address
  belongs_to :user
  belongs_to :item
  attr_accessor :token
  validates :item, presence: true
  validates :token, presence: true

  def save_with_shipping(shipping_data)
    saved = false
    transaction do
      return false unless self.valid?
    
      self.save!
      shipping_data[:purchase_record_id] = self.id
      
      address = ShippingAddress.new(shipping_data)
      unless address.valid?
        address.errors.each do |key, value|
          self.errors.add("shipping_address.#{key}", value)
        end
        raise ActiveRecord::Rollback
      else
        address.save!
        saved = true
      end
    end
    saved
  end
end
