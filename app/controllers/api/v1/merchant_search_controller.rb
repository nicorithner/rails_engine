class Api::V1::MerchantSearchController < ApplicationController
  def index
    if params[:name]
      merchants = Merchant.find_by_name(params[:name])
      render json: MerchantSerializer.new(merchants)
    end
    
  end
  def show
    if params[:name]
      merchant = Merchant.find_by_name(params[:name]).first
      render json: MerchantSerializer.new(merchant)
    end
  end
end