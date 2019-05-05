class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :invoice_id,
             :credit_card_number,
             :result
             # :credit_card_expiration_date,
end
