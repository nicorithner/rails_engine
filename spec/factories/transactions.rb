FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Finance.credit_card }
    result { "success" }
  end
end