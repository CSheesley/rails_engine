require 'rails_helper'

describe 'Merchant API' do

  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end

  it 'can get a single merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can find a single merchant by name param' do
    amazon = create(:merchant, name:"Amazon")

    get "/api/v1/merchants/find?name=#{amazon.name}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["name"]).to eq(amazon.name)
  end

  it 'can find a single merchant by id param' do
    amazon = create(:merchant, name:"Amazon")

    get "/api/v1/merchants/find?id=#{amazon.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)
    expect(merchant["data"]["attributes"]["id"]).to eq(amazon.id)
  end

  it 'can find a single merchant by date created at' do
    amazon = create(:merchant, name:"Amazon", created_at: "2012-03-27T14:54:05.000Z", updated_at: 2.days.ago)

    get "/api/v1/merchants/find?created_at=#{amazon.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["name"]).to eq(amazon.name)
  end

  it 'can find a single merchant by date updated at' do
    amazon = create(:merchant, name:"Amazon", created_at: 8.days.ago, updated_at: "2012-03-27T14:54:05.000Z")

    get "/api/v1/merchants/find?updated_at=#{amazon.updated_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["name"]).to eq(amazon.name)
  end
##########

  it 'can find all merchants by id param' do
    amazon = create(:merchant, name:"Amazon")
    ebay = create(:merchant, name:"eBay")
    etsy = create(:merchant, name:"Etsy")

    get "/api/v1/merchants/find_all?id=#{ebay.id}"

    expect(response).to be_successful
    
    merchant = JSON.parse(response.body)
    expected = merchant["data"].first["attributes"]["name"]

    expect(expected).to eq(ebay.name)
  end

end

# mom_pop = create(:merchant, name:"Mom & Pop", created_at: 8.days.ago, updated_at: 2.days.ago)
