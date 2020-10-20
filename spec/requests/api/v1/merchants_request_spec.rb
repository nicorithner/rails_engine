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
  end

  it "can get one merchant by its id" do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}"
    rsp = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful
    expect(rsp).to be_instance_of(Hash)
    expect(rsp.keys.first).to eq(:data)
    expect(rsp[:data][:id]).to eq("#{item.id}")
  end
end