class OrdersController < ApplicationController  
  # before_action :find_product_by_id, only: %i[new]
  
  def index
    @orders = Current.user.orders
  end

  def new
    @orders = Order.new
    @cart_items = Current.cart.cart_items

  end

  def create
    @order = Current.user.orders.new(order_params)
    @order.time_of_order = Time.now
    if params[:order_type]== "buy_now"
      @product = Product.find(params[:product_id])
      @order.total_amount = @product.price
      @order.save
      @order_items = @order.order_items.create(product_id: params[:product_id], quantity: 1)
    else 
      @order.total_amount = total_order_value
      @order.save
      Current.cart.cart_items.each do |cart_item|
        @order_items = @order.order_items.create(product_id: cart_item.product.id, quantity: cart_item.quantity)
      end
      Current.cart.cart_items.destroy_all
    end
    flash[:notice] = "Order placed Successfully!"
    redirect_to orders_path 
    end

  def buy_now
    @order = Current.user.orders.new
    @product = Product.find(params[:product_id])
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private

  def order_params
    params.permit(:address)
	end
  
  def total_order_value
    sum = 0
    Current.cart.cart_items.each do |cart_item|
      price = cart_item.product.price * cart_item.quantity
      sum += price
    end
    return sum
  end

  # def find_product_by_id
  #   product_id = params[:product_id]
  # end

  # def get_cart_products
  #   products_ids = []
  #   Current.cart.cart_items.each do |cart_item|
  #     products_ids << cart_item.product.id
  #   end
  #   return products_ids
  # end
end
