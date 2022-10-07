require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item) { FactoryBot.create(:order_item) }
  
  context 'validation test' do
    it "is valid with valid attributes" do
      expect(order_item).to be_valid
    end
  end

  context 'association tests' do
    it 'should belongs to product' do
      t = OrderItem.reflect_on_association(:product)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belongs to order' do
      t = OrderItem.reflect_on_association(:order)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
