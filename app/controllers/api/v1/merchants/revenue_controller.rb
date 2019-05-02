class Api::V1::Merchants::RevenueController<ApplicationController

  def show
    if params[:date].present?
      render json: TotalRevenueSerializer.new(Merchant.revenue_for_day(params[:date]))
    else
      render json: RevenueSerializer.new(Merchant.find(params[:id]))
    end
  end

end
