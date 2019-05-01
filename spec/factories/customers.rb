FactoryBot.define do
  factory :customer do
    sequence(:first_name) { |n| "Customer Name #{n}" }
    sequence(:last_name) { |n| "Customer Name #{n}" }
  end
end
