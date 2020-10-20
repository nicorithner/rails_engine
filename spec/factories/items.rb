FactoryBot.define do
  sequence :id do |n| "#{n}"; end
  factory :item do
    association :merchant
    id { generate :id }
    name { Faker::Commerce.product_name }
    description {Faker::Quotes::Shakespeare.hamlet_quote }
    unit_price {Faker::Commerce.price}
  end
end