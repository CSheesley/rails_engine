class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :invoice_id,
             :item_id,
             :unit_price,
             :quantity

  attribute :unit_price do |object|
    raw_unit_price = object.unit_price
    sprintf('%.2f', raw_unit_price / 100.to_f)
  end

end
