require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Relationships' do
    it { should have_many :items}
    it { should have_many :invoices}
  end

  describe 'Class Methods' do
    describe '.most_revenue' do
      it 'returns the top x number of merchants by revenue' do
        



      end
    end
  end
end
