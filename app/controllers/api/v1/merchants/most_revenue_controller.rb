class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    binding.pry
    render json: MerchantSerializer(Merchant.most_revenue())
  end

end
