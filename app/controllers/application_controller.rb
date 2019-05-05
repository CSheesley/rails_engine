class ApplicationController < ActionController::API

  def self.find_by_unit_price(key, value)
    value = value.delete(".").to_i
    find_by(key => value)
  end

  def self.where_by_unit_price(key, value)
    value = value.delete(".").to_i
    where(key => value)
  end

end
