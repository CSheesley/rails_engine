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



# def unit_price_check(key, value)
#   if key == "unit_price"
#     value = value.delete(".").to_i
#   else
#     key = params.keys.first
#     value = params.values.first
#   end
# end

# def by_unit_price(key, value)
#   value = value.delete(".").to_i
#   InvoiceItem.where(key => value)
# end
