class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[update destroy] 
  
  def index
    @cart_items = Current.cart.cart_items
  end

  def create
    @cart_item = Current.cart.cart_items.new(cart_item_params)
    @cart_item.quantity = 1
    if @cart_item.save
      redirect_back(fallback_location: root_path) 
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      redirect_back(fallback_location: root_path) 
    else
      redirect_back(fallback_location: root_path) 
    end
  end

  def destroy
    @cart_item.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_cart_item
    @cart_item = Current.cart.cart_items.find_by(product_id: params[:id])
    if @cart_item.blank?
      redirect_back(fallback_location: root_path)
    end
  end

  def cart_item_params
    params.permit(:quantity, :product_id)
  end
end
