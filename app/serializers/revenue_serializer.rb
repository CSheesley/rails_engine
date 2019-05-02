class RevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    raw_revenue_total = object.total_revenue
    raw_revenue_total.to_s.insert(-3, ".")
  end

end
