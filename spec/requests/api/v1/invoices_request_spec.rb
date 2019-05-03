require 'rails_helper'

describe 'invoices API' do
  context 'index and show' do
    it 'sends a list of invoices' do
      create_list(:invoice, 3)

      get "/api/v1/invoices"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]

      expect(invoices.count).to eq(3)
    end

    it 'can get a single invoices by id' do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(invoice["attributes"]["id"]).to eq(id)
    end
  end

  context 'find' do

    it 'can find a single invoice by id param' do
      invoice = create(:invoice)

      get "/api/v1/invoices/find?id=#{invoice.id}"

      expect(response).to be_successful

      invoice_resp = JSON.parse(response.body)["data"]
      expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
    end

    it 'can find a single invoice by customer_id param' do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)

      get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

      expect(response).to be_successful

      invoice_resp = JSON.parse(response.body)["data"]
      expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
    end

    it 'can find a single invoice by merchant_id param' do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)

      get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

      expect(response).to be_successful

      invoice_resp = JSON.parse(response.body)["data"]
      expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
    end

    it 'can find a single invoices by date created at' do
      invoice = create(:invoice, created_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

      expect(response).to be_successful

      invoice_resp = JSON.parse(response.body)["data"]

      expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
    end

    it 'can find a single invoices by date updated at' do
      invoice = create(:invoice, updated_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

      expect(response).to be_successful

      invoice_resp = JSON.parse(response.body)["data"]

      expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
    end
  end

  # context 'find_all' do
  #   it 'can find all invoicess by id param' do
  #     amazon = create(:invoices, name:"Amazon")
  #     ebay = create(:invoices, name:"eBay")
  #     etsy = create(:invoices, name:"Etsy")
  #
  #     get "/api/v1/invoicess/find_all?id=#{ebay.id}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #     expected = invoices.first["attributes"]["name"]
  #
  #     expect(expected).to eq(ebay.name)
  #   end
  #
  #   it 'can find all invoicess by name param' do
  #     amazon = create(:invoices, name:"Amazon")
  #     ebay = create(:invoices, name:"eBay")
  #     etsy = create(:invoices, name:"Etsy")
  #
  #     get "/api/v1/invoicess/find_all?name=#{etsy.name}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #     expected = invoices.first["attributes"]["name"]
  #
  #     expect(expected).to eq(etsy.name)
  #   end
  #
  #   it 'can find all invoicess by a created_at param' do
  #     created_at_param = "2012-03-27T14:54:05.000Z"
  #
  #     amazon = create(:invoices, name:"Amazon", created_at: created_at_param )
  #     ebay = create(:invoices, name:"eBay", created_at: created_at_param )
  #     etsy = create(:invoices, name:"Etsy")
  #
  #     get "/api/v1/invoicess/find_all?created_at=#{created_at_param}"
  #
  #     expect(response).to be_successful
  #
  #     invoicess = JSON.parse(response.body)["data"]
  #
  #     expect(invoicess.class).to eq(Array)
  #     expect(invoicess.count).to eq(2)
  #   end
  #
  #   it 'can find all invoicess by a updated_at param' do
  #     updated_at_param = "2013-03-27T14:54:05.000Z"
  #
  #     amazon = create(:invoices, name:"Amazon", updated_at: updated_at_param)
  #     ebay = create(:invoices, name:"eBay")
  #     etsy = create(:invoices, name:"Etsy", updated_at: updated_at_param)
  #     craigslist = create(:invoices, name:"Craigslist", updated_at: updated_at_param)
  #
  #     get "/api/v1/invoicess/find_all?updated_at=#{updated_at_param}"
  #
  #     expect(response).to be_successful
  #
  #     invoicess = JSON.parse(response.body)["data"]
  #
  #     expect(invoicess.class).to eq(Array)
  #     expect(invoicess.count).to eq(3)
  #   end
  #
  #   it 'can return a random invoices resource' do
  #     amazon = create(:invoices, name:"Amazon")
  #     ebay = create(:invoices, name:"eBay")
  #     etsy = create(:invoices, name:"Etsy")
  #
  #     get "/api/v1/invoicess/random"
  #
  #     expect(response).to be_successful
  #
  #     random_invoices = JSON.parse(response.body)["data"]
  #     unparsed = JSON.parse(response.body)
  #
  #     expect(random_invoices.class).to eq(Hash)
  #     expect(unparsed.count).to eq(1)
  #     expect(random_invoices["attributes"].present?).to eq(true)
  #   end
  # end
  #
  # context 'relationships' do
  #   it 'can return a collection of items associated with a invoices' do
  #     invoices = create(:invoices)
  #     item_list = create_list(:item, 3, invoices_id: invoices.id)
  #     other_item = create(:item)
  #
  #     get "/api/v1/invoicess/#{invoices.id}/items"
  #
  #     expect(response).to be_successful
  #
  #     invoicess_items = JSON.parse(response.body)["data"]
  #
  #     expect(invoicess_items.count).to eq(3)
  #   end
  #
  #   it 'can return a collection of invoices associated with a invoices' do
  #     invoices = create(:invoices)
  #     invoice_list = create_list(:invoice, 5, invoices_id: invoices.id)
  #     other_invoice = create(:item)
  #
  #     get "/api/v1/invoicess/#{merchant.id}/invoices"
  #
  #     expect(response).to be_successful
  #
  #     merchants_invoices = JSON.parse(response.body)["data"]
  #
  #     expect(merchants_invoices.count).to eq(5)
  #   end
  # end

end
