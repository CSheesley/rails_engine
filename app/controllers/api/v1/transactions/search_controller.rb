class Api::V1::Transactions::SearchController < ApplicationController

  def show
    key = params.keys.first
    value = params.values.first

    render json: TransactionSerializer.new(Transaction.find_by(key => value))
  end

  def index
    key = params.keys.first
    value = params.values.first

    render json: TransactionSerializer.new(Transaction.where(key => value).order(:id))
  end

end
