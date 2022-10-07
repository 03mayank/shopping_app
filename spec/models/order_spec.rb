require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryBot.create(:order) }

  context 'validation test' do
    it "is valid with valid attributes" do
      expect(order).to be_valid
    end

    it 'ensures address presence' do
      order.address = nil
      expect(subject).to_not be_valid
    end

    it 'ensures total amount presence' do
      order.total_amount = nil
      expect(order).to_not be_valid
    end


    it 'ensures total amount presence' do
      expect(order.total_amount).to be >  0    
    end
  end

  context 'association tests' do
    it 'should belongs to user' do
      t = Order.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  
    it 'should have many order_item' do
      t = Order.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end
  end
end
