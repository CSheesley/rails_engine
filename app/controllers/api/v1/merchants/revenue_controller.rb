class Api::V1::Merchants::RevenueController<ApplicationController

  def show
    render json: TotalRevenueSerializer.new(Merchant.revenue_for_day(params[:date]))
  end

end
