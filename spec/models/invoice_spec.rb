require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Relationships' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
    it { should have_one :invoice_item }
    it { should have_many :transactions }
  end
end
