require 'rails_helper'

describe 'Invoice_Items API' do
  context 'index and show' do
    it 'sends a list of invoices_items' do
      create_list(:invoice_item, 3)

      get "/api/v1/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expect(invoice_items.count).to eq(3)
    end

    it 'can get a single invoice_items by id' do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(invoice_item["attributes"]["id"]).to eq(id)
    end
  end

  context 'find' do

    it 'can find a single invoice_item by id param' do
      invoice_item = create(:invoice_item)

      get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]
      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end

    it 'can find a single invoice_item by invoice_id param' do
      invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]
      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end

    it 'can find a single invoice_item by item_id param' do
      item = create(:item)
      invoice_item = create(:invoice_item, item_id: item.id)

      get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]
      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end

    it 'can find a single invoice_item by quantity param' do
      quantity_param = 4
      invoice_item = create(:invoice_item, quantity: quantity_param)

      get "/api/v1/invoice_items/find?quantity=#{quantity_param}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]
      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end

    it 'can find a single invoice_item by unit_price param' do
      unit_price_param = "833.63"
      invoice_item = create(:invoice_item, unit_price: 83363)
  
      get "/api/v1/invoice_items/find?unit_price=#{unit_price_param}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]
      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end

    it 'can find a single invoice_items by date created at' do
      invoice_item = create(:invoice_item, created_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]

      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end

    it 'can find a single invoice_items by date updated at' do
      invoice_item = create(:invoice_item, updated_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"

      expect(response).to be_successful

      invoice_item_resp = JSON.parse(response.body)["data"]

      expect(invoice_item_resp["attributes"]["id"]).to eq(invoice_item.id)
    end
  end

  context 'find_all' do
    it 'can find all invoice_items by id param' do
      invoice_item_1 = create(:invoice_item)
      invoice_item_2 = create(:invoice_item)
      invoice_item_3 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expected = invoice_items.first["attributes"]["id"]

      expect(invoice_items.count).to eq(1)
      expect(expected).to eq(invoice_item_1.id)
    end

    it 'can find all invoice_items by invoice_id param' do
      invoice = create(:invoice)

      invoice_item_1 = create(:invoice_item, invoice_id: invoice.id)
      invoice_item_2 = create(:invoice_item, invoice_id: invoice.id)
      invoice_item_3 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?invoice_id=#{invoice.id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expected = invoice_items.first["attributes"]["id"]

      expect(invoice_items.count).to eq(2)
      expect(expected).to eq(invoice_item_1.id)
    end

    it 'can find all invoice_items by item_id param' do
      item = create(:item)

      invoice_item_1 = create(:invoice_item, item_id: item.id)
      invoice_item_2 = create(:invoice_item, item_id: item.id)
      invoice_item_3 = create(:invoice_item)

      get "/api/v1/invoice_items/find_all?item_id=#{item.id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expected = invoice_items.first["attributes"]["id"]

      expect(invoice_items.count).to eq(2)
      expect(expected).to eq(invoice_item_1.id)
    end

    it 'can find all invoice_items by quantity param' do
      quantity_param = 100

      invoice_item_1 = create(:invoice_item, quantity: 100)
      invoice_item_2 = create(:invoice_item, quantity: 100)
      invoice_item_3 = create(:invoice_item, quantity: 200)

      get "/api/v1/invoice_items/find_all?quantity=#{quantity_param}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]
      expected = invoice_items.first["attributes"]["id"]

      expect(invoice_items.count).to eq(2)
      expect(expected).to eq(invoice_item_1.id)
    end

    it 'can find all invoice_items by unit_price param' do
      unit_price_param = "833.63"

      invoice_item_1 = create(:invoice_item, unit_price: 83363)
      invoice_item_2 = create(:invoice_item, unit_price: 83363)
      invoice_item_3 = create(:invoice_item, unit_price: 10000)

      get "/api/v1/invoice_items/find_all?unit_price=#{unit_price_param}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)["data"]

      expected = invoice_items.first["attributes"]["id"]

      expect(invoice_items.count).to eq(2)
      expect(expected).to eq(invoice_item_1.id)
    end



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
  end

  context 'relationships' do
    it 'can return an invoice associated with an invoice item id' do
      invoice = create(:invoice)
      other_invoice = create(:invoice)

      invoice_item = create(:invoice_item, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

      expect(response).to be_successful

      invoice_resp = JSON.parse(response.body)["data"]

      expect(invoice_resp["attributes"]["id"]).to eq(invoice.id)
    end

    it 'can return an item associated with an invoice item id' do
      item = create(:item)
      other_item = create(:item)

      invoice_item = create(:invoice_item, item_id: item.id)

      get "/api/v1/invoice_items/#{invoice_item.id}/item"

      expect(response).to be_successful

      item_resp = JSON.parse(response.body)["data"]

      expect(item_resp["attributes"]["id"]).to eq(item.id)
    end
  end

end
