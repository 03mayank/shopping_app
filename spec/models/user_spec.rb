require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:subject) { FactoryBot.create(:user) }
  
  
  context 'validation test' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it 'ensures first name presence' do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it 'ensures last name presence' do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it 'ensures email presence' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'ensures email is uniquness' do
      subject.update(email: 'xyz@abc.com')
      expect(subject).to_not be_valid
    end

    it 'is not valid if the email is not with @ and domain name' do
      expect( (subject.email).match?(/\A[^@\s]+@[^@\s]+\z/) ).to eq(true)
    end

    it 'ensures mobile presence' do
      subject.mobile = nil
      expect(subject).to_not be_valid
    end

    it "is not valid if the  number is not 10 chars" do
      expect(subject.mobile.length). to eq(10)
    end

    it 'is not valid if the phone number is not all digits' do
      expect( (subject.mobile).match?(/\A-?\d+\Z/) ).to eq(true)
    end
  end

  context 'association tests' do
    it 'should have a cart' do
      t = User.reflect_on_association(:cart)
      expect(t.macro).to eq(:has_one)
    end

    it 'should have many addresses' do
      t = User.reflect_on_association(:addresses)
      expect(t.macro).to eq(:has_many)
    end

    it 'should have many orders' do
      t = User.reflect_on_association(:orders)
      expect(t.macro).to eq(:has_many)
    end
  end
end
