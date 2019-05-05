class Api::V1::Items::SearchController < ApplicationController

  def show
    key = params.keys.first
    value = params.values.first

    if key == "unit_price"
      render json: ItemSerializer.new(Item.find_by_unit_price(key, value))
    elsif key == "created_at" || key == "updated_at"
      render json: ItemSerializer.new(Item.find_first_by_date(key, value))
    else
      render json: ItemSerializer.new(Item.find_by(key => value))
    end
  end

  def index
    key = params.keys.first
    value = params.values.first

    if key == "unit_price"
      render json: ItemSerializer.new(Item.where_by_unit_price(key, value).order(:id))
    else
      render json: ItemSerializer.new(Item.where(key => value).order(:id))
    end
  end

end
