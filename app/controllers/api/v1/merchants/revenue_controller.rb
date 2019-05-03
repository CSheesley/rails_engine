class Api::V1::Merchants::RevenueController<ApplicationController

  def index
    render json: TotalRevenueSerializer.new(Merchant.revenue_for_day(params[:date]))

  end

  def show
    merchant = Merchant.find(params[:id])

    if params[:date].present?
      render json: RevenueDateSerializer.new(merchant, {params: { date: params[:date] }})
    else
      render json: RevenueSerializer.new(merchant)
    end
  end

end
