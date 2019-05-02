require 'rails_helper'

describe 'Merchant API' do
  context 'index and show' do
    it 'sends a list of merchants' do
      create_list(:merchant, 3)

      get "/api/v1/merchants"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants.count).to eq(3)
    end

    it 'can get a single merchant by id' do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(merchant["attributes"]["id"]).to eq(id)
    end
  end

  context 'find' do
    it 'can find a single merchant by name param' do
      amazon = create(:merchant, name:"Amazon")

      get "/api/v1/merchants/find?name=#{amazon.name}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]
      expect(merchant["attributes"]["name"]).to eq(amazon.name)
    end

    it 'can find a single merchant by id param' do
      amazon = create(:merchant, name:"Amazon")

      get "/api/v1/merchants/find?id=#{amazon.id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]
      expect(merchant["attributes"]["id"]).to eq(amazon.id)
    end

    it 'can find a single merchant by date created at' do
      amazon = create(:merchant, name:"Amazon", created_at: "2012-03-27T14:54:05.000Z", updated_at: 2.days.ago)

      get "/api/v1/merchants/find?created_at=#{amazon.created_at}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["attributes"]["name"]).to eq(amazon.name)
    end

    it 'can find a single merchant by date updated at' do
      amazon = create(:merchant, name:"Amazon", created_at: 8.days.ago, updated_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/merchants/find?updated_at=#{amazon.updated_at}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]

      expect(merchant["attributes"]["name"]).to eq(amazon.name)
    end
  end

  context 'find_all' do
    it 'can find all merchants by id param' do
      amazon = create(:merchant, name:"Amazon")
      ebay = create(:merchant, name:"eBay")
      etsy = create(:merchant, name:"Etsy")

      get "/api/v1/merchants/find_all?id=#{ebay.id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]
      expected = merchant.first["attributes"]["name"]

      expect(expected).to eq(ebay.name)
    end

    it 'can find all merchants by name param' do
      amazon = create(:merchant, name:"Amazon")
      ebay = create(:merchant, name:"eBay")
      etsy = create(:merchant, name:"Etsy")

      get "/api/v1/merchants/find_all?name=#{etsy.name}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body)["data"]
      expected = merchant.first["attributes"]["name"]

      expect(expected).to eq(etsy.name)
    end

    it 'can find all merchants by a created_at param' do
      created_at_param = "2012-03-27T14:54:05.000Z"

      amazon = create(:merchant, name:"Amazon", created_at: created_at_param )
      ebay = create(:merchant, name:"eBay", created_at: created_at_param )
      etsy = create(:merchant, name:"Etsy")

      get "/api/v1/merchants/find_all?created_at=#{created_at_param}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants.class).to eq(Array)
      expect(merchants.count).to eq(2)
    end

    it 'can find all merchants by a updated_at param' do
      updated_at_param = "2013-03-27T14:54:05.000Z"

      amazon = create(:merchant, name:"Amazon", updated_at: updated_at_param)
      ebay = create(:merchant, name:"eBay")
      etsy = create(:merchant, name:"Etsy", updated_at: updated_at_param)
      craigslist = create(:merchant, name:"Craigslist", updated_at: updated_at_param)

      get "/api/v1/merchants/find_all?updated_at=#{updated_at_param}"

      expect(response).to be_successful

      merchants = JSON.parse(response.body)["data"]

      expect(merchants.class).to eq(Array)
      expect(merchants.count).to eq(3)
    end

    it 'can return a random merchant resource' do
      amazon = create(:merchant, name:"Amazon")
      ebay = create(:merchant, name:"eBay")
      etsy = create(:merchant, name:"Etsy")

      get "/api/v1/merchants/random"

      expect(response).to be_successful

      random_merchant = JSON.parse(response.body)["data"]
      unparsed = JSON.parse(response.body)

      expect(random_merchant.class).to eq(Hash)
      expect(unparsed.count).to eq(1)
      expect(random_merchant["attributes"].present?).to eq(true)
    end
  end

  context 'relationships' do
    it 'can return a collection of items associated with a merchant' do
      merchant = create(:merchant)
      item_list = create_list(:item, 3, merchant_id: merchant.id)
      other_item = create(:item)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_successful

      merchants_items = JSON.parse(response.body)["data"]

      expect(merchants_items.count).to eq(3)
    end
  end

end
