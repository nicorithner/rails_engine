require 'rails_helper'

describe "Expose Restful API endpoints for merchants" do
  it "Sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    rsp = JSON.parse(response.body, symbolize_names: true)

    expect(rsp).to be_instance_of(Hash)
    expect(rsp.keys.first).to eq(:data)
    expect(rsp[:data]).to be_instance_of(Array)
    expect(rsp[:data].count).to eq(3)

    rsp[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}"
    rsp = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(rsp).to be_instance_of(Hash)
    expect(rsp.keys.first).to eq(:data)
    expect(rsp[:data][:id]).to eq("#{merchant.id}")
  end

  it "can create a new merchant" do
    merchant_params = { "name": "Merchant Name"}
    post "/api/v1/merchants", params: merchant_params
    
    rsp = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(rsp[:data][:attributes][:name]).to eq(merchant_params[:name])
  end

  it "can update an merchant" do
    merchant = create(:merchant)
    merchant_name = Merchant.first.name
    merchant_params = { "name": 'Another Name' }
    
    patch "/api/v1/merchants/#{merchant.id}", params: merchant_params
    
    rsp = JSON.parse(response.body, symbolize_names: true)
    
    merchant = Merchant.find_by(id: merchant.id)
    
    updated_merchant = rsp[:data]
    expect(updated_merchant[:attributes][:name]).to eq(merchant.name)
    expect(updated_merchant[:attributes][:name]).to_not eq(merchant_name)
  end

  it 'can destroy an merchant' do
    merchant = create(:merchant)
    expect(Merchant.count).to eq(1)
    delete "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
  end
end