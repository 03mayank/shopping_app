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
    @order = Current.user.orders.build(order_attributes)
    @order.save!
    Current.cart.cart_items.destroy_all if params[:order_type] != "buy_now"
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

  def order_attributes
    order_attributes = order_params.merge(time_of_order: Time.current)
    if params[:order_type]== "buy_now"
      @product = Product.find(params[:product_id])
      order_attributes.merge(
        total_amount: @product.price,
        order_items_attributes: [{product_id: @product.id, quantity: 1}]
      )
    else 
      order_attributes.merge(
        total_amount: Cart.total_cart_price(Current.cart.cart_items), 
        order_items_attributes: Current.cart.cart_items.map{|ci| ci.slice(:product_id, :quantity)}
      )
    end
  end
end
