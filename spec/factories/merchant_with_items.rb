def merchant_with_items(items_count: 3)
  FactoryBot.create(:merchant) do |merchant|
    FactoryBot.create_list(:item, items_count, merchant: merchant)
  end
end