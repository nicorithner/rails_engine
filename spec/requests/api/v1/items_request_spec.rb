require 'rails_helper'

describe "Expose Restful API endpoints for both Items" do
  it "Sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    rsp = JSON.parse(response.body, symbolize_names: true)

    expect(rsp).to be_instance_of(Hash)
    expect(rsp.keys.first).to eq(:data)
    expect(rsp[:data]).to be_instance_of(Array)
    expect(rsp[:data].count).to eq(3)

    rsp[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)
    end
  end

  it "can get one item by its id" do
    item = create(:item)
    get "/api/v1/items/#{item.id}"
    rsp = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(rsp).to be_instance_of(Hash)
    expect(rsp.keys.first).to eq(:data)
    expect(rsp[:data][:id]).to eq("#{item.id}")
  end
  
  it "can create a new item" do
    item_params = { "name": "Item_1", "description": "Item's description", "merchant_id": "12345", "unit_price": "10.05" }
    post "/api/v1/items", params: {item: item_params}
    
    rsp = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(rsp[:data][:attributes][:name]).to eq(item_params[:name])
    expect(rsp[:data][:attributes][:description]).to eq(item_params[:description])
  end

  it "can update an item" do
    item = create(:item)
    item_name = Item.first.name
    item_params = { "name": 'Table Saw' }
    
    patch "/api/v1/items/#{item.id}", params: {item: item_params}
    
    rsp = JSON.parse(response.body, symbolize_names: true)
    
    item = Item.find_by(id: item.id)
    
    updated_item = rsp[:data]
    expect(updated_item[:attributes][:name]).to eq(item.name)
    expect(updated_item[:attributes][:description]).to eq(item.description)
    expect(updated_item[:attributes][:unit_price]).to eq(item.unit_price)
    expect(updated_item[:attributes][:merchant_id]).to eq(item.merchant_id)
    expect(updated_item[:attributes][:name]).to_not eq(item_name)
  end

  it 'can destroy an item' do
    item = create(:item)
    expect(Item.count).to eq(1)
    delete "/api/v1/items/#{item.id}"
    expect(response).to be_successful
    expect(Item.count).to eq(0)
  end
end