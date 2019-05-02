require 'rails_helper'

describe 'Customer API' do
  context 'index and show' do
    it 'sends a list of customers' do
      create_list(:customer, 3)

      get "/api/v1/customers"

      expect(response).to be_successful

      customers = JSON.parse(response.body)["data"]

      expect(customers.count).to eq(3)
    end

    it 'can get a single customers by id' do
      id = create(:customer).id

      get "/api/v1/customers/#{id}"

      customer = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(customer["attributes"]["id"]).to eq(id)
    end
  end

  context 'find' do
    it 'can find a single customer by id param' do
      joe = create(:customer)

      get "/api/v1/customers/find?id=#{joe.id}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]
      expect(customer["attributes"]["id"]).to eq(joe.id)
    end

    it 'can find a single customer by first_name param' do
      joe = create(:customer)

      get "/api/v1/customers/find?first_name=#{joe.first_name}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]
      expect(customer["attributes"]["first_name"]).to eq(joe.first_name)
    end

    it 'can find a single customer by last_name param' do
      joe = create(:customer)

      get "/api/v1/customers/find?last_name=#{joe.last_name}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]
      expect(customer["attributes"]["first_name"]).to eq(joe.last_name)
    end

    it 'can find a single customer by created at' do
      joe = create(:customer, created_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/customers/find?created_at=#{joe.created_at}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]

      expect(customer["attributes"]["id"]).to eq(joe.id)
    end

    it 'can find a single customer by updated at' do
      joe = create(:customer, updated_at: "2012-03-27T14:54:05.000Z")

      get "/api/v1/customers/find?updated_at=#{joe.updated_at}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]

      expect(customer["attributes"]["id"]).to eq(joe.id)
    end
  end

  context 'find_all' do
    it 'can find all customers by id param' do
      joe = create(:customer, first_name: "joe")
      tom = create(:customer, first_name: "tom")
      bob = create(:customer, first_name: "bob")

      get "/api/v1/customers/find_all?id=#{joe.id}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]
      expected = customer.first["attributes"]["id"]

      expect(expected).to eq(joe.id)
    end

    it 'can find all customers by id param' do
      joe = create(:customer, first_name: "joe")
      tom = create(:customer, first_name: "tom")
      bob = create(:customer, first_name: "bob")

      get "/api/v1/customers/find_all?id=#{joe.id}"

      expect(response).to be_successful

      customer = JSON.parse(response.body)["data"]
      expected = customer.first["attributes"]["id"]

      expect(expected).to eq(joe.id)
    end

  end



end
