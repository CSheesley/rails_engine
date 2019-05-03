require 'rails_helper'

describe 'All Merchants API - Business Intelligence' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)
    @item_4 = create(:item, merchant: @merchant_4)

    @invoice_1 = create(:invoice, merchant: @merchant_1, created_at: "2012-03-16")
    @invoice_2 = create(:invoice, merchant: @merchant_2, created_at: "2012-03-16")
    @invoice_3 = create(:invoice, merchant: @merchant_3)
    @invoice_4 = create(:invoice, merchant: @merchant_4)

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:failed_transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)

    @invoice_item_1 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_1,
      quantity: 50,
      unit_price: 51)

    @invoice_item_2 = create(:invoice_item,
      item: @item_2,
      invoice: @invoice_2,
      quantity: 40,
      unit_price: 40)

    @invoice_item_3 = create(:invoice_item,
      item: @item_3,
      invoice: @invoice_3,
      quantity: 20,
      unit_price: 50)

    @invoice_item_4 = create(:invoice_item,
      item: @item_4,
      invoice: @invoice_4,
      quantity: 200,
      unit_price: 50)
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

  it 'can get the top x number of merchants by total items sold' do
    quantity = 2

    get "/api/v1/merchants/most_items?quantity=#{quantity}"

    top_two_merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(top_two_merchants.count).to eq(2)
    expect(top_two_merchants.first["attributes"]["id"]).to eq(@merchant_4.id)
    expect(top_two_merchants.second["attributes"]["id"]).to eq(@merchant_1.id)
  end

  it 'can get total revenue for all merchants by a single date' do
    date = "2012-03-16"

    get "/api/v1/merchants/revenue?date=#{date}"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants["attributes"]["total_revenue"]).to eq("41.50")
  end
end

describe 'Single Merchants API - Business Intelligence' do
  before :each do
    @merch_1 = create(:merchant)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @item_1 = create(:item, merchant: @merch_1)

    @invoice_1 = create(:invoice, merchant: @merch_1, customer: @customer_1, created_at: "2012-03-16")
    @invoice_2 = create(:invoice, merchant: @merch_1, customer: @customer_1, created_at: "2012-03-16")
    @invoice_3 = create(:invoice, merchant: @merch_1, customer: @customer_2)
    @invoice_4 = create(:invoice, merchant: @merch_1, customer: @customer_2)

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
    @transaction_4 = create(:failed_transaction, invoice: @invoice_4)

    @invoice_item_1 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_1,
      quantity: 5,
      unit_price: 5)

    @invoice_item_2 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_2,
      quantity: 4,
      unit_price: 4)

    @invoice_item_3 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_3,
      quantity: 3,
      unit_price: 3)

    @invoice_item_4 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_4,
      quantity: 2,
      unit_price: 2)
  end

  it 'can get total revenue for a single merchant based on successful transactions' do
    id = @merch_1.id

    get "/api/v1/merchants/#{id}/revenue"

    merch_revenue = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merch_revenue["attributes"]["revenue"]).to eq("0.50")
  end

  it 'can get total revenue for a single merchant based on a specific invoice date' do
    date = "2012-03-16"

    get "/api/v1/merchants/#{@merch_1.id}/revenue?date=#{date}"

    merch_revenue = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(merch_revenue["attributes"]["revenue"]).to eq("0.41")
  end

  xit 'can return the merchants favorite customer: most successful transactions with merchants' do
    # date =

    get "/api/v1/merchants/:id/favorite_customer"

    # merch_revenue = JSON.parse(response.body)["data"]
    #
    # expect(response).to be_successful
    # expect(merchants["attributes"]["total_revenue"]).to eq("41.50")
  end

end
