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
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code は「3桁ハイフン4桁」の形式で入力してください")
      end

      it '郵便番号は、3桁ハイフン4桁の半角文字列のみ保存可能であること' do
        @shipping_address.postal_code = '1234567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Postal code は「3桁ハイフン4桁」の形式で入力してください")
      end

      it '都道府県が必須であること' do
        @shipping_address.prefecture_id = 0
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Prefecture を選択してください")
      end

      it '市区町村が必須であること' do
        @shipping_address.city = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が必須であること' do
        @shipping_address.street_address = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が必須であること' do
        @shipping_address.phone_number = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @shipping_address.phone_number = '123456789'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number は10桁以上11桁以下の半角数字で入力してください")
      end
  
      it '電話番号が12桁以上では購入できない' do
        @shipping_address.phone_number = '123456789012'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number は10桁以上11桁以下の半角数字で入力してください")
      end

      it '電話番号に半角数字以外が含まれている場合は購入できない' do
        @shipping_address.phone_number = '123abc4567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number は10桁以上11桁以下の半角数字で入力してください")
      end
    end
  end
end