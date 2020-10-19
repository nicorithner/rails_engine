FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Commerce.product_name }
    description {Faker::Quotes::Shakespeare.hamlet_quote }
    unit_price {Faker::Commerce.price}
  end
end