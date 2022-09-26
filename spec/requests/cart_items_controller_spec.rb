require 'rails_helper'

RSpec.describe "CartItemsControllers", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  before do
    allow(Current).to receive(:user).and_return(user)
  end
  let!(:cart) { FactoryBot.create(:cart, user: user) }
  let!(:product) { FactoryBot.create(:product) }
  let!(:cart_item) { FactoryBot.create(:cart_item, product: product, cart: cart) }
  
  
  describe "GET /index" do
    it "should render the index" do
      get cart_items_path 
      expect(response).to render_template('index')
    end
  end

  describe "POST /create" do
    it "should add product to a cart" do
      params = {
        product: {
          quantity: 1
        }
      }
      post product_cart_items_path(product.id), params: params
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(root_path)   
    end
  end

  describe "DESTROY /delete" do
    it "should remove a product from cart" do
      delete product_cart_item_path(cart_item.id, product.id)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
