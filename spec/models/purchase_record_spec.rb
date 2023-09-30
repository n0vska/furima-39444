require 'rails_helper'

RSpec.describe PurchaseRecord, type: :model do
  before do
    @user = create(:user)
    @item = create(:item, user: @user)
    @purchase_record = create(:purchase_record, user: @user, item: @item)
  end

  describe '購入成功テスト' do
    it '必要な情報が適切に入力されていれば購入できる' do
      expect(@purchase_record).to be_valid
    end
  end

  describe 'エラーハンドリングテスト' do
    it '入力に問題がある場合は購入できない' do
      @purchase_record.user = nil
      expect(@purchase_record).to_not be_valid
    end
  end
end
