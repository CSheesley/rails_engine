class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.favorite_merchant_of(params[:id]))
  end

end
