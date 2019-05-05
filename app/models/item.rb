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

  def self.find_by_unit_price(key, value)
    value = value.delete(".").to_i
    find_by(key => value)
  end

  def self.where_by_unit_price(key, value)
    value = value.delete(".").to_i
    where(key => value)
  end

  def self.find_first_by_date(key, value)
    Item.where(key => value).first
  end

  def best_day
    Invoice.joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where("invoice_items.item_id = ?", self.id)
    .select("invoices.created_at as invoice_date, SUM(invoice_items.quantity) as total")
    .group(:created_at)
    .order("total DESC", created_at: "DESC")
    .limit(1)[0]
  end

end
