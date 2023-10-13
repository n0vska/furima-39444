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
    it '入力に問題がある場合は購入できない' do
      @purchase_record.user = nil
      expect(@purchase_record).to_not be_valid
    end
  end
end
