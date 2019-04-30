FactoryBot.define do
  factory :invoice_item do
    invoice
    item
    sequence(:quantity) { |n| (n + 1) * 2 }
    sequence(:unit_price) { |n| (n + 1) * 5 }
  end
end
