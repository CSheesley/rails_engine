require 'rails_helper'

describe 'Transactions API' do
  context 'index and show' do
    it 'sends a list of transactions' do
      create_list(:transaction, 3)

      get "/api/v1/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)["data"]

      expect(transactions.count).to eq(3)
    end

    it 'can get a single transactions by id' do
      id = create(:transaction).id

      get "/api/v1/transactions/#{id}"

      transaction = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(transaction["attributes"]["id"]).to eq(id)
    end
  end

  context 'find' do
    # add find tests - passes spec harness
  end

  context 'find all' do
    # add find all tests - passes spec harness
  end

  context 'relationships' do
    it 'can return the associated invoice with a transaction id' do
      invoice_1 = create(:invoice)
      invoice_2 = create(:invoice)

      transaction = create(:transaction, invoice_id: invoice_1.id)

      get "/api/v1/transactions/#{transaction.id}/invoice"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    end
  end

end
