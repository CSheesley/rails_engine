require 'rails_helper'

describe 'Merchant API - Business Intelligence' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)
    @item_4 = create(:item, merchant: @merchant_4)

    @invoice_1 = create(:invoice, merchant: @merchant_1)
    @invoice_2 = create(:invoice, merchant: @merchant_2)
    @invoice_3 = create(:invoice, merchant: @merchant_3)
    @invoice_4 = create(:invoice, merchant: @merchant_4)

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:failed_transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)

    @invoice_item_1 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_1,
      quantity: 5,
      unit_price: 5)

    @invoice_item_2 = create(:invoice_item,
      item: @item_2,
      invoice: @invoice_2,
      quantity: 4,
      unit_price: 4)

    @invoice_item_3 = create(:invoice_item,
      item: @item_3,
      invoice: @invoice_3,
      quantity: 2,
      unit_price: 5)

    @invoice_item_4 = create(:invoice_item,
      item: @item_4,
      invoice: @invoice_4,
      quantity: 20,
      unit_price: 5)
  end

  it 'can get the top x number of merchants by total revenue' do

    quantity = 2
    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    top_two_merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(top_two_merchants.count).to eq(2)
    expect(top_two_merchants.first["attributes"]["name"]).to eq(@merchant_4.name)
    expect(top_two_merchants.first["attributes"]["id"]).to eq(@merchant_4.id)
  end

end
