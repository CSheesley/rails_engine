class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(invoice_items: {invoice: :transactions})
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    select("items.*, COUNT(transactions.id) as total")
    .joins(invoice_items: {invoice: :transactions})
    .merge(Transaction.successful)
    .group(:id)
    .order("total DESC")
    .limit(quantity)
  end
end
