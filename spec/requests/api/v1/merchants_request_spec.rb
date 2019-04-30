require 'rails_helper'

describe 'Merchant API' do

  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(3)
  end

  it 'can get a single merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["id"]).to eq(id)
  end

  it 'can find a single merchant by name param' do
    amazon = create(:merchant, name:"Amazon", created_at: 3.days.ago, updated_at: 2.days.ago)
    name_search = "name=#{amazon.name}"

    get "/api/v1/merchants/find?#{name_search}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["name"]).to eq(amazon.name)
  end

  it 'can find a single merchant by id param' do
    amazon = create(:merchant, name:"Amazon", created_at: 3.days.ago, updated_at: 2.days.ago)
    id_search = "id=#{amazon.id}"

    get "/api/v1/merchants/find?#{id_search}"

    expect(response).to be_successful
    
    merchant = JSON.parse(response.body)
    expect(merchant["id"]).to eq(amazon.id)
  end

end

# mom_pop = create(:merchant, name:"Mom & Pop", created_at: 8.days.ago, updated_at: 2.days.ago)
