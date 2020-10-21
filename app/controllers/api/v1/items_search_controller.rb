class Api::V1::ItemsSearchController < ApplicationController
  def index
    if params[:name]
      items = Item.find_by_name(params[:name])
      render json: ItemSerializer.new(items)
    end
    
  end
  def show
    if params[:name]
      item = Item.find_by_name(params[:name]).first
      render json: ItemSerializer.new(item)
    end
  end
end