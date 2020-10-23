class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(merchant.items)
  end

  def show
    item = Item.find(params[:id])
    merchant = item.merchant.id
    render json: MerchantSerializer.new(Merchant.find(merchant))
  end
end
