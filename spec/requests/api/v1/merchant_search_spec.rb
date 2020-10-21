require 'rails_helper'
describe "search Merchant endpoints" do
  
  it 'can find a list of merchants that contain a fragment, case insensitive' do
    Merchant.create!({ name: "Schiller" })
    Merchant.create!({ name: "Barrows and Parker" })
    Merchant.create!({ name: "Tillman Group" })
    Merchant.create!({ name: "Williamson Group" })
    Merchant.create!({ name: "Williamson Group" })
    Merchant.create!({ name: "Willms and Sons" })

    get '/api/v1/merchants/find_all?name=ILL'

    json = JSON.parse(response.body, symbolize_names: true)
    names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(names.sort).to eq(["Schiller", "Tillman Group", "Williamson Group", "Williamson Group", "Willms and Sons"])
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