require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.create(:product) }

  context 'validation test' do
    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it 'ensures name presence' do
      product.name = nil
      expect(product).to_not be_valid
    end
  
    it 'ensures description presence' do
      product.description = nil
      expect(product).to_not be_valid
    end

    it 'ensures price presence' do
      product.price = nil
      expect(product).to_not be_valid
    end

    it 'ensures stock presence' do
      product.stock = nil
      expect(product).to_not be_valid
    end

    it 'ensures product_images presence' do
      product.product_images = nil
      expect(product).to_not be_valid
    end

    it 'ensures category name presence' do
      product.category = nil
      expect(product).to_not be_valid
    end
  end
  
  context 'association tests' do
    it 'should have a cart' do
      t = Product.reflect_on_association(:category)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should have many order_items' do
      t = Product.reflect_on_association(:order_items)
      expect(t.macro).to eq(:has_many)
    end
  end
end
