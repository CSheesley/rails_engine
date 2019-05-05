class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices


  def self.favorite_customer_of(merchant)

    Customer.select("customers.*, COUNT(transactions.id) as total")
      .joins(invoices: :transactions)
      .where("invoices.merchant_id = ?", merchant)
      .merge(Transaction.successful)
      .group(:id)
      .order("total DESC")
      .limit(1)[0]
  end
end
