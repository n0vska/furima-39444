class PurchaseRecordsController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :redirect_if_not_allowed, only: [:index, :create]

  def index
    @purchase_record = PurchaseRecord.new
  end

  def create
    @purchase_record = PurchaseRecord.new(purchase_record_params)
  
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  
    if @purchase_record.save_with_shipping(shipping_address_params)
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record).permit(:price).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def shipping_address_params
    params.require(:purchase_record).permit(:postal_code, :prefecture_id, :city, :street_address, :phone_number)
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
