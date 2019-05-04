class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue do |object|
    raw_revenue_total = object.all_revenue
    sprintf('%.2f', raw_revenue_total / 100.to_f)
  end

end
