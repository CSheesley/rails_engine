class BestDaySerializer
  include FastJsonapi::ObjectSerializer

  attribute :best_day do |invoice|
    invoice = invoice.invoice_date
    invoice.strftime('%Y-%m-%d')
  end
end
