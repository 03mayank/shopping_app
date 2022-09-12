class CartsController < ApplicationController
  def index
    @cart_items = Current.user.cart.cart_items.includes(:product)
  end
  
end
