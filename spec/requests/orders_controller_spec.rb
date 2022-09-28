require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do

  let!(:user) { FactoryBot.create(:user) }
  let!(:order) { FactoryBot.create(:order, user: user) }
  let(:attributes) do 
    { address: '95, Shakti Nagar, Indore, MP, Pin.- 452002',
      total_amount: 82990,
      time_of_order: Time.current,
      time_of_delivery: Time.current + 7.days }
  end

  before do
    allow(Current).to receive(:user).and_return(user)
    allow_any_instance_of(OrdersController).to receive(:order_attributes).and_return(attributes)
  end

   describe "GET /index" do
    it "should render the index" do
      get orders_path 
      expect(response).to render_template('index')
    end
  end

  describe "GET /new" do
    it "should render the index" do
      get new_order_path
      expect(response).to render_template('new')
    end
  end

  describe "GET /show" do
    it "should render show" do
      get order_path(order.id)
      expect(response).to render_template('show')
    end
  end

  describe "POST /create" do
    it "should create order" do
      post orders_path
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(orders_path)  
      expect(flash[:notice]).to match("Order placed Successfully!")
    end
  end

  describe "POST /create" do
    it "should create order" do
      post orders_path
      expect(response.status).to eq(302)  
      expect(response).to redirect_to(orders_path)   
    end
  end
end
     

