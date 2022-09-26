require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:cart_item) { FactoryBot.create(:cart_item) }
  
  context 'association tests' do
    it 'should belongs to product' do
      t = CartItem.reflect_on_association(:product)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belongs to cart' do
      t = CartItem.reflect_on_association(:cart)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  context 'validation test' do
    it "is valid with valid attributes" do
      expect(cart_item).to be_valid
    end

    it 'ensures quantity presence' do
      cart_item.quantity = nil
      expect(cart_item).to_not be_valid
    end

    it 'ensures quantity in range 1 and 5' do
      expect(cart_item.quantity).to be_between(1, 5).inclusive
    end
  end
end
