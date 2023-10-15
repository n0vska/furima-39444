require 'rails_helper'

RSpec.describe PurchaseRecord, type: :model do
  before do
    @purchase_record = FactoryBot.build(:purchase_record)
  end

  context '購入成功テスト' do
    it '必要な情報が適切に入力されていれば購入できる' do
      expect(@purchase_record).to be_valid
    end
  end

  context 'エラーハンドリングテスト' do
    it 'userが紐づいていなければ登録できない' do
      @purchase_record.user = nil
      @purchase_record.valid?
      expect(@purchase_record.errors.full_messages).to include("User must exist")
    end

    it 'itemが紐づいていなければ登録できない' do
      @purchase_record.item = nil
      @purchase_record.valid?
      expect(@purchase_record.errors.full_messages).to include("Item can't be blank")
    end

    it 'tokenが空では登録できない' do
      @purchase_record.token = nil
      @purchase_record.valid?
      expect(@purchase_record.errors.full_messages).to include("Token can't be blank")
    end
  end
end
