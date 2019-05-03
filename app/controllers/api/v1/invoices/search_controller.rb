class Api::V1::Invoices::SearchController < ApplicationController

  def show
    key = params.keys.first
    value = params.values.first

    render json: InvoiceSerializer.new(Invoice.find_by(key => value))
  end

  def index
    key = params.keys.first
    value = params.values.first

    render json: InvoiceSerializer.new(Invoice.where(key => value).order(:id))
  end

end
