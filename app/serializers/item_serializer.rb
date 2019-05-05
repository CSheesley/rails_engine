class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :name,
             :merchant_id,
             :description,
             :unit_price
             
  attribute :unit_price do |object|
   raw_unit_price = object.unit_price
   sprintf('%.2f', raw_unit_price / 100.to_f)
  end

end
