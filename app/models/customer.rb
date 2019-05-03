class Customer < ApplicationRecord
  has_many :invoices


  def self.favorite_customer_of(merchant)

    Customer.select("customers.*, COUNT(transactions.id) as total")
      .joins(invoices: :transactions)
      .where("invoices.merchant_id = ?", merchant)
      .merge(Transaction.successful)
      .group(:id)
      .order("total DESC")
      .take
  end
end
