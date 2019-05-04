class Api::V1::Items::BestDayController < ApplicationController

  def show
    render json: BestDaySerializer.new(Item.find(params[:id]).best_day)
  end

end
