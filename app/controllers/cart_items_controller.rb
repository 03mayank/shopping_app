class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[update destroy] 
  
  def index
    @cart_items = Current.cart.cart_items
  end

  def create
    @cart_item = Current.cart.cart_items.new(cart_item_params)
    @cart_item.quantity = 1
    if @cart_item.save
      flash.now[:notice] = 'Cart item was successfully added'
    end
    redirect_back(fallback_location: root_path) 
  end

  def update
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      flash.now[:notice] = 'Updated quantity'
    end
    redirect_back(fallback_location: root_path)  
  end

  def destroy
    @cart_item.destroy
    flash.now[:notice] = 'Cart item removed'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_cart_item
    @cart_item = Current.cart.cart_items.find_by(product_id: params[:id])
  end

  def cart_item_params
    params.permit(:quantity, :product_id)
  end
end
