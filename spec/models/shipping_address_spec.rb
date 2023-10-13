require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before(:all) do
    user = create(:user)
    item = create(:item, user: user)
    purchase_record = create(:purchase_record, user: user, item: item)
    @shipping_address = build(:shipping_address, purchase_record: purchase_record)
  end

  describe 'バリデーションテスト' do
    context '商品購入ができる時' do
      it '全ての項目が正しく入力されていれば購入できる' do
        expect(@shipping_address).to be_valid
      end

      it '建物名は任意であること' do
        @shipping_address.building_name = nil
        expect(@shipping_address).to be_valid
      end
    end

    context '商品購入ができない時' do
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
end
