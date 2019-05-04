class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :name,
             :merchant_id,
             :description,
             :unit_price

  attribute :best_day do |item|
    date = item.best_day.created_at
    date.strftime('%Y-%m-%d')
  end

  # belongs_to :merchant
  # has_many :invoice_items
  # has_many :invoices, through: :invoice_items
end
