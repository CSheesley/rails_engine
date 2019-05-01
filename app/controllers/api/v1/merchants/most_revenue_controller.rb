class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: MerchantSerializer(Merchant.most_revenue)
  end

end
