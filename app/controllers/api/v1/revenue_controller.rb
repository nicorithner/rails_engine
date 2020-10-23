class Api::V1::RevenueController < ApplicationController
  def date_range
    revenue = RevenueFacade.date_range(params[:start], params[:end])
    render json: RevenueSerializer.new(revenue)
  end
  
end