require 'rails_helper'

describe "Expose Restful API relationship endpoints" do
  it "Return all items associated with a merchant" do
  merchant = merchant_with_items
  get "/api/v1/merchants/#{merchant.id}/items"
  
  expect(response).to be_successful
  rsp = JSON.parse(response.body, symbolize_names: true)
  expect(rsp[:data].count).to eq(3)
  end

  it "Return merchant associated with item" do
    item_1, item_2, item_3 = merchant_with_items.items
    get "/api/v1/items/#{item_1.id}/merchant"
    
    rsp = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
  end
end