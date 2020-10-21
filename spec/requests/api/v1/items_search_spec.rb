require 'rails_helper'

describe "search items endpoints" do
  it 'can find a list of items that contain a fragment, case insensitive' do
    merchant1 = Merchant.create!({ name: "Schiller" })
    item1 = merchant1.items.create!({ name: "Haru_1", description: "Item's description",  unit_price: 10.05 })
    item2 = merchant1.items.create!({ name: "Haru_2", description: "Item's description",  unit_price: 10.05 })
    item3 = merchant1.items.create!({ name: "Not_It", description: "Item's description",  unit_price: 10.05 })

    get '/api/v1/items/find_all?name=haru'
    
    json = JSON.parse(response.body, symbolize_names: true)

    names = json[:data].map do |merchant|
      merchant[:attributes][:name].downcase
    end

    expect(names.count).to eq(2)
    names.each do |name|
      expect(name).to include('haru')
    end
  end

  it 'can find an item that contain a fragment, case insensitive' do
    merchant1 = Merchant.create!({ name: "Schiller" })
    item1 = merchant1.items.create!({ name: "Haru_1", description: "Item's description",  unit_price: 10.05 })
    item2 = merchant1.items.create!({ name: "Haru_2", description: "Item's description",  unit_price: 10.05 })
    item3 = merchant1.items.create!({ name: "Not_It", description: "Item's description",  unit_price: 10.05 })
    
    get '/api/v1/items/find?name=haru'
    json = JSON.parse(response.body, symbolize_names: true)
    name = json[:data][:attributes][:name].downcase

    expect(json[:data]).to be_a(Hash)
    expect(name).to include('haru')
  end
end