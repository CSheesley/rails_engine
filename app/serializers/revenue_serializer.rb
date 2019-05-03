class RevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    raw_revenue_total = object.total_revenue
    sprintf('%.2f', raw_revenue_total / 100.to_f)
  end

end
