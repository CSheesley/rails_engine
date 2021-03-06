FactoryBot.define do
  factory :item do
    merchant
    sequence(:name) { |n| "Item Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:unit_price) { |n| (n + 1) * 1.5 }
  end
end
