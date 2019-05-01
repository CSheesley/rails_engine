class Api::V1::Merchants::SearchController < ApplicationController

  def show
    # key = params.keys.first
    # value = params.values.first
    #
    # render json: MerchantSerializer.new(Merchant.find_by(key => params[value]))

    render json: MerchantSerializer.new(Merchant.find_by_id(params[:id])) if params[:id].present?
    render json: MerchantSerializer.new(Merchant.find_by_name(params[:name])) if params[:name].present?
    render json: MerchantSerializer.new(Merchant.find_by_created_at(params[:created_at])) if params[:created_at].present?
    render json: MerchantSerializer.new(Merchant.find_by_updated_at(params[:updated_at])) if params[:updated_at].present?
  end

 def index
   render json: MerchantSerializer.new(Merchant.where(id: params[:id])) if params[:id].present?
   render json: MerchantSerializer.new(Merchant.where(name: params[:name])) if params[:name].present?
   render json: MerchantSerializer.new(Merchant.where(created_at: params[:created_at])) if params[:created_at].present?
   render json: MerchantSerializer.new(Merchant.where(updated_at: params[:updated_at])) if params[:updated_at].present?
 end

end
