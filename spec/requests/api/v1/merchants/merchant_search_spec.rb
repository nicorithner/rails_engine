require 'rails_helper'
describe "search Merchant endpoints" do
  
  it 'can find a list of merchants that contain a fragment, case insensitive' do
    merchant1 = Merchant.create!({ name: "Schiller" })
    merchant2 = Merchant.create!({ name: "Barrows and Parker" })
    merchant3 = Merchant.create!({ name: "Tillman Group" })
    merchant4 = Merchant.create!({ name: "Williamson Group" })
    merchant5 = Merchant.create!({ name: "Williamson Group" })
    merchant6 = Merchant.create!({ name: "Willms and Sons" })

    get '/api/v1/merchants/find_all?name=ILL'

    binding.pry
    json = JSON.parse(response.body, symbolize_names: true)
    names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(names.sort).to eq(["Barrows and Parker", "Schiller", "Tillman Group", "Williamson Group", "Williamson Group", "Willms and Sons"])
  end

  it 'can find a merchants that contain a fragment, case insensitive' do
    merchant1 = Merchant.create!({ name: "Schiller" })
    
    get '/api/v1/merchants/find?name=ILL'

    json = JSON.parse(response.body, symbolize_names: true)
    name = json[:data][:attributes][:name].downcase

    expect(json[:data]).to be_a(Hash)
    expect(name).to include('ill')
  end
end