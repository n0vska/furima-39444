require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before(:all) do
    # 既存のレコードを全て削除
    User.destroy_all
    Item.destroy_all
    PurchaseRecord.destroy_all
  
    # ここで新しいレコードを作成
    user = create(:user)
    item = create(:item, user: user)
    purchase_record = create(:purchase_record, user: user, item: item)
    @shipping_address = build(:shipping_address, purchase_record: purchase_record)
    
    puts @shipping_address.valid?
    puts @shipping_address.errors.full_messages
  end

  describe 'バリデーションテスト' do
    it '郵便番号が必須であること' do
      @shipping_address.postal_code = nil
      expect(@shipping_address).to_not be_valid
    end

    it '郵便番号は、3桁ハイフン4桁の半角文字列のみ保存可能であること' do
      @shipping_address.postal_code = '1234567'
      expect(@shipping_address).to_not be_valid
    end


      it '都道府県が必須であること' do
      @shipping_address.prefecture_id = nil
      expect(@shipping_address).to_not be_valid
    end

    it '市区町村が必須であること' do
      @shipping_address.city = nil
      expect(@shipping_address).to_not be_valid
    end

    it '番地が必須であること' do
      @shipping_address.street_address = nil
      expect(@shipping_address).to_not be_valid
    end

    it '建物名は任意であること' do
      @shipping_address.postal_code = '123-4567'
      @shipping_address.prefecture_id = 1
      @shipping_address.city = 'Tokyo'
      @shipping_address.street_address = '1-1-1'
      
      @shipping_address.building_name = nil
      expect(@shipping_address).to be_valid
    end
  
    it '電話番号が必須であること' do
      @shipping_address.phone_number = nil
      expect(@shipping_address).to_not be_valid
    end
  
    it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能であること' do
      @shipping_address.phone_number = '090-1234-5678'
      expect(@shipping_address).to_not be_valid
    end
  end
end