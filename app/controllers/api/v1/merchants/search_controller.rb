class Api::V1::Merchants::SearchController < ApplicationController

  def show
    render json: MerchantSerializer.new(Merchant.find_by_id(params[:id])) if params[:id].present?
    render json: MerchantSerializer.new(Merchant.find_by_name(params[:name])) if params[:name].present?
    render json: MerchantSerializer.new(Merchant.find_by_created_at(params[:created_at])) if params[:created_at].present?
    render json: MerchantSerializer.new(Merchant.find_by_updated_at(params[:updated_at])) if params[:updated_at].present?
  end

 def index
   # binding.pry
   render json: MerchantSerializer.new(Merchant.where(id: params[:id])) if params[:id].present?
 end

end
