module ApplicationHelper
  def cart_item?(product_id)
    return true if Current.cart.cart_items.pluck(:product_id).include?(product_id)   
  end
end
