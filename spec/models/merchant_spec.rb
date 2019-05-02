require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)
    @merchant_4 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_3)
    @item_4 = create(:item, merchant: @merchant_4)

    @invoice_1 = create(:invoice, merchant: @merchant_1, created_at: "2012-03-27")
    @invoice_2 = create(:invoice, merchant: @merchant_2, created_at: "2012-03-27")
    @invoice_3 = create(:invoice, merchant: @merchant_3)
    @invoice_4 = create(:invoice, merchant: @merchant_4)

    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:failed_transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)

    @invoice_item_1 = create(:invoice_item,
      item: @item_1,
      invoice: @invoice_1,
      quantity: 5,
      unit_price: 5)

    @invoice_item_2 = create(:invoice_item,
      item: @item_2,
      invoice: @invoice_2,
      quantity: 4,
      unit_price: 4)

    @invoice_item_3 = create(:invoice_item,
      item: @item_3,
      invoice: @invoice_3,
      quantity: 2,
      unit_price: 5)

    @invoice_item_4 = create(:invoice_item,
      item: @item_4,
      invoice: @invoice_4,
      quantity: 20,
      unit_price: 5)
  end

  describe 'Relationships' do
    it { should have_many :items}
    it { should have_many :invoices}
  end

  describe 'Class Methods' do
    describe '.most_revenue()' do
      it 'returns the top x number of merchants by revenue' do

        expect(Merchant.most_revenue(2).length).to eq(2)
        expect(Merchant.most_revenue(2)).to eq([@merchant_4, @merchant_1])
      end
    end

    describe '.most_items()' do
      it 'returns the top x number of merchants by items' do

        expect(Merchant.most_revenue(2).length).to eq(2)
        expect(Merchant.most_revenue(2)).to eq([@merchant_4, @merchant_1])
      end
    end

    describe '.revenue_for_day()' do
      it 'returns merchants revenues based on a day' do
        date = '2012-03-27'

        expect(Merchant.revenue_for_day(date).all_revenue).to eq(41)
      end
    end
  end
end
