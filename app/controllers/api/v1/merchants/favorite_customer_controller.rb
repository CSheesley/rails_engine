class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.favorite_customer_of(params[:id]))
  end

end
