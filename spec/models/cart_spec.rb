require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:cart) { FactoryBot.create(:cart) }

  context 'association tests' do
    it 'should have a user' do
      t = Cart.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should have a user' do
      t = Cart.reflect_on_association(:cart_items)
      expect(t.macro).to eq(:has_many)
    end
  end
end
