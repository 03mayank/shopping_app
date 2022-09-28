require 'rails_helper'

RSpec.describe "ProductsControllers", type: :request do

  let!(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:category) }  
  let!(:product) { FactoryBot.create(:product, category: category) }
  before do
    allow(Current).to receive(:user).and_return(user)
  end
  describe "GET /index" do
    it "should render the index" do
      get products_path 
      expect(response).to render_template('index')
    end
  end

  describe "GET /new" do
    it "should render the index" do
      user.email = "admin@sz.com"
      get new_product_path
      expect(response).to render_template('new')
    end
  end

  describe "GET /edit" do
    it "should render edit" do
      user.email = "admin@sz.com"
      get edit_product_path(product.id)
      expect(response).to render_template('edit')
    end
  end

  describe "GET /show" do
    it "should render show" do
      get product_path(product.id)
      expect(response).to render_template('show')
    end
  end

  describe "POST /create" do
    it "should create product" do
      params = {
        product: {
          name:	'SONY Alpha ILCE-6400L',
          description: 'Mirrorless Camera with 16-50mm Power Zoom Lens (Black)',
          price: 79990,
          stock: 1000,
          product_images:  [Rack::Test::UploadedFile.new('spec/factories/fixtures/camera.png', 'image/png'), 
            Rack::Test::UploadedFile.new('spec/factories/fixtures/camera1.png', 'image/png')],
          category_name: 'Electronic'
        }
      }
      user.email = "admin@sz.com"
      post products_path, params: params
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(products_path)  
      expect(flash[:notice]).to match('Product Added successfully') 
    end

    it "if create product fails" do
      params = {
        product: {
          description: 'Mirrorless Camera with 16-50mm Power Zoom Lens (Black)',
          price: 79990,
          stock: 1000,
          product_images:  [Rack::Test::UploadedFile.new('spec/factories/fixtures/camera.png', 'image/png'), 
            Rack::Test::UploadedFile.new('spec/factories/fixtures/camera1.png', 'image/png')],
          category_name: 'Electronic'
        }
      }
      user.email = "admin@sz.com"
      post products_path, params: params
      expect(response.status).to eq(422)  
      expect(response).to render_template('new')  
    end
  end

  describe "PATCH /update" do
    it "should update product" do
      params = {
        product: {
          name:	'SONY Alpha ILCE-6400L',
          description: 'Mirrorless Camera with 16-50mm Power Zoom Lens (Black)',
          price: 109000,
          stock: 1000,
          product_images:  [Rack::Test::UploadedFile.new('spec/factories/fixtures/camera.png', 'image/png'), 
            Rack::Test::UploadedFile.new('spec/factories/fixtures/camera1.png', 'image/png')],
          category_name: 'Electronic'
        }
      }
      user.email = "admin@sz.com"
      patch product_path(product.id), params: params
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(products_path)  
      expect(flash[:notice]).to match('Product updated successfully')  
    end
  end

  describe "DESTROY\ delete" do
    it "should delete a product" do
      delete product_path(product.id)
      expect(response.status).to eq(302)
      expect(response).to redirect_to(products_path)
    end
  end
end
