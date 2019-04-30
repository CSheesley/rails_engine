FactoryBot.define do
  factory :merchant, class: Merchant do
sequence(:name) { |n| "Merchant Name #{n}" }  end
end
