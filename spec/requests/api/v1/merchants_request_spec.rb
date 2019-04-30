require 'rails_helper'

describe 'Merchant API' do

  it 'sends a list of merchants' do
    create_list(:merchant, 3)
    binding.pry
  end

end
