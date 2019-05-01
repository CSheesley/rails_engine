class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.most_revenue(count)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(items: :invoice_items)
    .group(:id)
    .order("revenue DESC")
    .limit(count)
    # .joins(invoices: :transactions)
    # .where("transactions.result = ?", 0)
  end
end
