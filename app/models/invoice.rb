class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_one :invoice_item
  has_many :transactions

  enum status: [:shipped, :not_shipped]
end
