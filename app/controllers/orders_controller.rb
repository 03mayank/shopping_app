class OrdersController < ApplicationController  
  
  def index
    @orders = Current.user.orders
  end

  def new
    @cart_items = Current.cart.cart_items
  end

  def create
    @order = Current.user.orders.build(order_attributes)
    if @order.save!
      Current.cart.cart_items.destroy_all if params[:order_type] != "buy_now"
      OrderMailer.with(order: @order, user: Current.user).new_order_email.deliver_later
      flash[:notice] = "Order placed Successfully!"
      redirect_to orders_path 
    end
  end

  def buy_now
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
        order_items_attributes: [{product_id: @product.id, quantity: 1, price: @product.price}]
      )
    else
      order_attributes.merge(
        total_amount: Current.cart.total_cart_value, 
<<<<<<< HEAD
        order_items_attributes: 
          Current.cart.cart_items.map{|ci| ci.slice(:product_id, :quantity).merge(price: ci.product.price)}
=======
        order_items_attributes: Current.cart.cart_items.map{|ci| ci.slice(:product_id, :quantity)}
>>>>>>> Implementing Action Mailer
      )
    end
  end
end
    
