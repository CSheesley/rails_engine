require 'rails_helper'

describe 'Merchant API - Business Intelligence' do

  it 'can get the top x number of merchants by total revenue' do
    


    quantity = 2
    get "/api/v1/merchants/most_revenue?quantity#{quantity}"

    expect(response).to be_successful
  end

end
