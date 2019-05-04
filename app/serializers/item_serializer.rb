class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :name,
             :merchant_id,
             :description,
             :unit_price
end
