namespace :import do

  desc "rake import data from customer csv file"

    task customer: :environment do
      require 'csv'
      CSV.foreach('db/data/customers.csv', :headers => true)do|row|
      Customer.create!(row.to_hash)
    end
  end

  desc "rake import data from merchant csv file"

    task merchant: :environment do
      require 'csv'
      CSV.foreach('db/data/merchants.csv', :headers => true)do|row|
      Merchant.create!(row.to_hash)
    end
  end

  desc "rake import data from invoice csv file"

    task invoice: :environment do
      require 'csv'
      CSV.foreach('db/data/invoices.csv', :headers => true)do|row|
      Invoice.create!(row.to_hash)
    end
  end

  desc "rake import data from item csv file"

    task item: :environment do
      require 'csv'
      CSV.foreach('db/data/items.csv', :headers => true)do|row|
      Item.create!(row.to_hash)
    end
  end

  desc "rake import data from invoice_item csv file"

    task invoice_item: :environment do
      require 'csv'
      CSV.foreach('db/data/invoice_items.csv', :headers => true)do|row|
      InvoiceItem.create!(row.to_hash)
    end
  end

  desc "rake import data from transaction csv file"

    task transaction: :environment do
      require 'csv'
      CSV.foreach('db/data/transactions.csv', :headers => true)do|row|
      Transaction.create!(row.to_hash)
    end
  end
end

# rake import:{customer,merchant,invoice,item,invoiceitem,transaction}
