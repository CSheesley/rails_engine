class RevenueDateSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |merchant, params|
    raw_revenue_total = merchant.revenue_on_date(params[:date])
    sprintf('%.2f', raw_revenue_total / 100.to_f)
  end

end
