require 'rails_helper'

describe 'Items API' do
  context 'index and show' do
    it 'sends a list of items' do
      create_list(:item, 3)

      get "/api/v1/items"

      expect(response).to be_successful

      items = JSON.parse(response.body)["data"]

      expect(items.count).to eq(3)
    end

    it 'can get a single items by id' do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(item["attributes"]["id"]).to eq(id)
    end
  end

  context 'find' do

  #   it 'can find a single invoice by id param' do
  #     invoice = create(:invoice)
  #
  #     get "/api/v1/invoices/find?id=#{invoice.id}"
  #
  #     expect(response).to be_successful
  #
  #     invoice_resp = JSON.parse(response.body)["data"]
  #     expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
  #   end
  #
  #   it 'can find a single invoice by customer_id param' do
  #     customer = create(:customer)
  #     invoice = create(:invoice, customer_id: customer.id)
  #
  #     get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"
  #
  #     expect(response).to be_successful
  #
  #     invoice_resp = JSON.parse(response.body)["data"]
  #     expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
  #   end
  #
  #   it 'can find a single invoice by merchant_id param' do
  #     merchant = create(:merchant)
  #     invoice = create(:invoice, merchant_id: merchant.id)
  #
  #     get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"
  #
  #     expect(response).to be_successful
  #
  #     invoice_resp = JSON.parse(response.body)["data"]
  #     expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
  #   end

    it 'can find the first item by date created at' do
      item_1 = create(:item, created_at: "2012-03-27T14:54:05.000Z")
      item_2 = create(:item, created_at: "2012-03-27T14:55:05.000Z")
      item_3 = create(:item, created_at: "2012-03-27T14:56:05.000Z")

      get "/api/v1/items/find?created_at=#{item_1.created_at}"

      expect(response).to be_successful

      item_resp = JSON.parse(response.body)["data"]

      expect(item_resp["attributes"]["id"]).to eq(item_1.id)
    end

    it 'can find a single items by date updated at' do
      item = create(:item, updated_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/items/find?updated_at=#{item.updated_at}"

      expect(response).to be_successful

      item_resp = JSON.parse(response.body)["data"]

      expect(item_resp["attributes"]["id"]).to eq(item.id)
    end
  end
  #
  # context 'find_all' do
  #   it 'can find all invoices by id param' do
  #     invoice_1 = create(:invoice)
  #     invoice_2 = create(:invoice)
  #     invoice_3 = create(:invoice)
  #
  #     get "/api/v1/invoices/find_all?id=#{invoice_1.id}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #     expected = invoices.first["attributes"]["id"]
  #
  #     expect(expected).to eq(invoice_1.id)
  #   end
  #
  #   it 'can find all invoices by customer_id param' do
  #     customer_1 = create(:customer)
  #     customer_2 = create(:customer)
  #
  #     invoice_1 = create(:invoice, customer_id: customer_1.id)
  #     invoice_2 = create(:invoice, customer_id: customer_1.id)
  #     invoice_3 = create(:invoice, customer_id: customer_2.id)
  #
  #     get "/api/v1/invoices/find_all?customer_id=#{customer_1.id}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #     expected = invoices.first["attributes"]["customer_id"]
  #
  #     expect(expected).to eq(customer_1.id)
  #   end
  #
  #   it 'can find all invoices by merchant_id param' do
  #     merchant_1 = create(:merchant)
  #     merchant_2 = create(:merchant)
  #
  #     invoice_1 = create(:invoice, merchant_id: merchant_1.id)
  #     invoice_2 = create(:invoice, merchant_id: merchant_1.id)
  #     invoice_3 = create(:invoice, merchant_id: merchant_2.id)
  #
  #     get "/api/v1/invoices/find_all?merchant_id=#{merchant_1.id}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #     expected = invoices.first["attributes"]["merchant_id"]
  #
  #     expect(expected).to eq(merchant_1.id)
  #   end
  #
  #   it 'can find all invoices by a created_at param' do
  #     created_at_param = "2012-03-27T14:54:05.000Z"
  #
  #     invoice_1 = create(:invoice, created_at: created_at_param)
  #     invoice_2 = create(:invoice, created_at: created_at_param)
  #     invoice_3 = create(:invoice)
  #
  #     get "/api/v1/invoices/find_all?created_at=#{created_at_param}"
  #
  #     expect(response).to be_successful
  #
  #     invoicess = JSON.parse(response.body)["data"]
  #
  #     expect(invoicess.class).to eq(Array)
  #     expect(invoicess.count).to eq(2)
  #   end
  #
  #   it 'can find all invoices by a updated_at param' do
  #     updated_at_param = "2012-03-27T14:54:05.000Z"
  #
  #     invoice_1 = create(:invoice, created_at: updated_at_param)
  #     invoice_2 = create(:invoice, created_at: updated_at_param)
  #     invoice_3 = create(:invoice)
  #
  #     get "/api/v1/invoices/find_all?created_at=#{updated_at_param}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #
  #     expect(invoices.class).to eq(Array)
  #     expect(invoices.count).to eq(2)
  #   end
  #
  #   it 'can find all invoices by a status' do
  #     successful = 0
  #
  #     invoice_1 = create(:invoice, status: 0)
  #     invoice_2 = create(:invoice, status: 0)
  #     invoice_3 = create(:invoice, status: 1)
  #
  #     get "/api/v1/invoices/find_all?status=#{successful}"
  #
  #     expect(response).to be_successful
  #
  #     invoices = JSON.parse(response.body)["data"]
  #
  #     expect(invoices.class).to eq(Array)
  #     expect(invoices.count).to eq(2)
  #   end
  #
  #   it 'can return a random invoice resource' do
  #     invoice_1 = create(:invoice)
  #     invoice_2 = create(:invoice)
  #     invoice_3 = create(:invoice)
  #
  #     get "/api/v1/invoices/random"
  #
  #     expect(response).to be_successful
  #
  #     unparsed = JSON.parse(response.body)
  #     random_invoices = JSON.parse(response.body)["data"]
  #
  #     expect(unparsed.count).to eq(1)
  #     expect(random_invoices.class).to eq(Hash)
  #     expect(random_invoices["attributes"].present?).to eq(true)
  #   end
  # end

  context 'relationships' do
    it 'can return a list of invoice_items associated with an item id' do
      item = create(:item)

      invoice_items = create_list(:invoice_item, 3, item_id: item.id)
      other_invoice_item = create(:invoice_item)

      get "/api/v1/items/#{item.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items.count).to eq(3)
    end

    it 'can return the merchant associated with an item id' do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get "/api/v1/items/#{item.id}/merchant"

      expect(response).to be_successful

      merchant_resp = JSON.parse(response.body)["data"]

      expect(merchant_resp["attributes"]["id"]).to eq(merchant.id)
    end
  end

end
