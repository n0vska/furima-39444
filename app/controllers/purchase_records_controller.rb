class PurchaseRecordsController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_not_allowed, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @purchase_record = PurchaseRecord.new
  end

  def create
    Rails.logger.debug "Token: #{params[:token]}"
    @item = Item.find(params[:item_id])
    @purchase_record = PurchaseRecord.new
    @purchase_record.user_id = current_user.id 
    @purchase_record.item_id = params[:item_id]
    @purchase_record.token = params[:token]
  
    Payjp.api_key = "sk_test_cccecbd471246f4255bf1856"  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  
    shipping_address = {
      postal_code: params[:purchase_record][:postal_code],
      prefecture_id: params[:purchase_record][:prefecture_id],
      city: params[:purchase_record][:city],
      street_address: params[:purchase_record][:street_address],
      phone_number: params[:purchase_record][:phone_number]
    }
  
    if @purchase_record.save_with_shipping(shipping_address)
      Rails.logger.debug "保存に成功しました"
      redirect_to root_path
    else
      Rails.logger.debug "保存に失敗しました"
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record).permit(:price).merge(token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
  
  def redirect_if_not_allowed
    if @item.sold_out? || @item.user_id == current_user.id
      redirect_to root_path
    end
  end
end




