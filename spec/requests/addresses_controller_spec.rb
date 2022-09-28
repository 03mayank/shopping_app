require 'rails_helper'

RSpec.describe "AddressesControllers", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:address) { FactoryBot.create(:address, user: user) }
  
  before do
    allow(Current).to receive(:user).and_return(user)
  end

  describe "GET /new" do
    it "renders the new template of address" do
      get new_user_address_path(user.id)
      expect(response).to render_template('new')
    end  
  end

  describe "POST /create" do
    it "creates a new address" do
      params = {
        address: {
          area: '268G, Sneh Nagar',
          city:  'Jabalpur',
          pincode:  '480001', 
          state: 'MP'
        }
      }
      post user_addresses_path(user.id), params: params
      expect(response.status).to eq(302)
      expect(flash[:notice]).to match('Address Added successfully')

    end

    it "creates a new address with blank field" do
      params = {
        address: {
          area: '268G, Sneh Nagar',
          city:  'Jabalpur',       
          pincode:  '', 
          state: 'MP'
        }
      }
      post user_addresses_path(user.id), params: params
      expect(response.status).to eq(422)
    end

    it "redirection after a new address created" do
      params = {
        address: {
          area: '268G, Sneh Nagar',
          city:  'Jabalpur',    
          pincode:  '482001', 
          state: 'MP'
        }
      }
      post user_addresses_path(user.id), params: params
      expect(response).to redirect_to(user_addresses_path)
    end

    it "Redirection after a new address fail to new " do
      params = {
        address: {
          area: '268G, Sneh Nagar',
          city:  'Jabalpur',
          pincode:  '', 
          state: 'MP'
        }
      }
      post user_addresses_path(user.id), params: params
      expect(response).to render_template(:new)
    end
  end

  describe "GET /create" do
    it "it renders the edit form for address" do
      get edit_user_address_path(user.id, address.id)
      expect(response).to render_template('edit')
    end
  end

  describe "PATCH /update" do
    it "updates the address" do
      params = {
        address: {
          area: '45, Shrivastav Colony',
          city:  'Chhindwara',
          pincode:  '480001', 
          state: 'MP'
        }
      }
      patch user_address_path(user.id, address.id), params: params
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(user_addresses_path)   
      expect(flash[:notice]).to match('Address Modified successfully')
    end

    it "update the address on fails" do
      params = {
        address: {
          area: '45, Shrivastav Colony',
          city:  'Chhindwara',
          pincode:  '', 
          state: 'MP'
        }
      }
      patch user_address_path(user.id, address.id), params: params
      expect(response.status).to eq(422)  
      expect(response).to render_template(:edit) 
    end
  end

  describe "DESTROY /delete" do
    it "should destroy the address" do
      delete user_address_path(user.id, address.id)
      expect(response.status).to eq(303)
      expect(response).to redirect_to(user_addresses_path)
      expect(flash[:notice]).to match('Address Deleted')
    end
  end
end 
    
    

