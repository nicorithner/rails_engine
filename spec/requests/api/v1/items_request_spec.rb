require 'rails_helper'

describe "Expose Restful API endpoints for both Items" do
  it "Sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
  end
end