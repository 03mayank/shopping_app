require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryBot.create(:address) }



  context 'validation test' do
    it "is valid with valid attributes" do
      expect(address).to be_valid
    end

    it 'ensures area presence' do
      address.area = nil
      expect(address).to_not be_valid
    end

    it 'ensures city presence' do
      address.city = nil
      expect(address).to_not be_valid
    end

    it 'ensures pincode presence' do
      address.pincode = nil
      expect(address).to_not be_valid
    end

    it 'ensures city presence' do
      address.city = nil
      expect(address).to_not be_valid
    end

    it "is not valid if the  pincode is not 6 chars" do
      expect(address.pincode.length). to eq(6)
    end

    it 'is not valid if the pincode number is not all digits' do
      expect( (address.pincode).match?(/\A-?\d+\Z/) ).to eq(true)
    end

    it 'ensures state presence' do
      address.state = nil
      expect(address).to_not be_valid
    end
  end

  context 'association tests' do
    it 'should belongs a user' do
      t = Address.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
  
