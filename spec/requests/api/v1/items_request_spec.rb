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

  context 'find_all' do
    # include find_all tests
  end

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
