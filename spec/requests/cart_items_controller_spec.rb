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
        cart_item: {
          quantity: 1
        }
      }
      post product_cart_items_path(product.id), params: params
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(root_path)   
      expect(flash[:notice]).to match('Cart item successfully added')
    end
  end

  describe "PATCH /update" do
    it "should update product quanrtity to a cart" do
      params = {
        cart_item: {
          quantity: 3
        }
      }
      patch product_cart_item_path(cart_item.id, product.id), params: params
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(root_path)   
      expect(flash[:notice]).to match('Updated quantity')
    end
  end

  describe "DESTROY /delete" do
    it "should remove a product from cart" do
      delete product_cart_item_path(cart_item.id, product.id)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to match('Cart item removed')
    end
  end
end
