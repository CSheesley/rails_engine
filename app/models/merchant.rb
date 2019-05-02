class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("revenue DESC")
    .limit(quantity)
  end

  def self.most_items(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS total_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .group(:id)
    .order("total_sold DESC")
    .limit(quantity)
  end

  def self.revenue_for_day(date)

    Invoice.joins(:invoice_items, :transactions)
    .select("SUM(invoice_items.quantity * invoice_items.unit_price) as all_revenue")
    .merge(Transaction.successful)
    .where("invoices.created_at::timestamp::date = ?", date)[0]
  end

end
