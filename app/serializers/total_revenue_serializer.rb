class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue do |object|
    raw_revenue_total = object.attributes["all_revenue"]
    raw_revenue_total.to_s.insert(-3, ".")
  end

end
