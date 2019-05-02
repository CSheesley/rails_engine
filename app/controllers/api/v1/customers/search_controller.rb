class Api::V1::Customers::SearchController < ApplicationController

  def show
    key = params.keys.first
    value = params.values.first
    # binding.pry
    render json: CustomerSerializer.new(Customer.find_by(key => value))
  end

  def index
    key = params.keys.first
    value = params.values.first
    # binding.pry
    render json: CustomerSerializer.new(Customer.where(key => value))
  end



end
