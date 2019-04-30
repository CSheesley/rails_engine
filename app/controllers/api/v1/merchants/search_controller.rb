class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: Merchant.find_by_id(params[:id]) if params[:id].present?
    render json: Merchant.find_by_name(params[:name]) if params[:name].present?
  end


end
