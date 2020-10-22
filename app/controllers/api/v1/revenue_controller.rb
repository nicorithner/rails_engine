class Api::V1::RevenueController < ApplicationController
  def date_range
    revenue = Revenue.date_range(params[:start], params[:end])
    # binding.pry
    render json: RevenueSerializer.new(revenue)
  end
  
end