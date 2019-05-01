FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| (4580251236515201 * n).to_s[0..15] }
    credit_card_expiration_date { "" }
    result { "success" }

    factory :failed_transaction, parent: :transaction do
      result {"failed"}
    end
  end
end
