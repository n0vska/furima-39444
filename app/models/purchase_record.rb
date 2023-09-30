class PurchaseRecord < ApplicationRecord
  has_one :shipping_address
  belongs_to :user
  belongs_to :item

  def save_with_shipping(shipping_data)
    saved = false
    transaction do
      return false unless self.valid?
  
      self.save!
      shipping_data[:purchase_record_id] = self.id # ここでpurchase_record_idを設定
  
      address = ShippingAddress.new(shipping_data)
      unless address.valid?
        self.errors.add(:base, "Shipping address is invalid")
        raise ActiveRecord::Rollback
      else
        address.save!
        saved = true
      end
    end
    saved
  end
end