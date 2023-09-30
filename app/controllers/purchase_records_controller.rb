class PurchaseRecordsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @purchase_record = PurchaseRecord.new
  end

  def create
    @purchase_record = PurchaseRecord.new
    @purchase_record.user_id = current_user.id 
    @purchase_record.item_id = params[:item_id] 

    shipping_data = {
      postal_code: params[:purchase_record][:postal_code],
      prefecture_id: params[:purchase_record][:prefecture_id],
      city: params[:purchase_record][:city],
      street_address: params[:purchase_record][:street_address],
      phone_number: params[:purchase_record][:phone_number]
    }

    if @purchase_record.save_with_shipping(shipping_data)
      Rails.logger.debug "保存に成功しました"
      redirect_to root_path
    else
      Rails.logger.debug "保存に失敗しました"
      Rails.logger.debug @purchase_record.errors.full_messages.to_sentence
      @item = Item.find(params[:item_id])
      render :index
    end
  end
end




