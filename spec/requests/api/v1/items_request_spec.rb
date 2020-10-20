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
end