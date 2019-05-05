class Api::V1::InvoiceItems::SearchController < ApplicationController

  def show
    key = params.keys.first
    value = params.values.first

    if key == "unit_price"
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by_unit_price(key, value))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(key => value))
    end
  end

  def index
    key = params.keys.first
    value = params.values.first

    if key == "unit_price"
      render json: InvoiceItemSerializer.new(InvoiceItem.where_by_unit_price(key, value).order(:id))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.where(key => value).order(:id))
    end
  end

end
