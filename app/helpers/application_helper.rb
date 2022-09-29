module ApplicationHelper
  
  def cart_item?(product_id)
    return true if Current.cart.cart_items.pluck(:product_id).include?(product_id)   
  end

  def address_cancatination
    all_address = []
    Current.user.addresses.each do |address|
      add = address.area + ", " +  address.city + ", " + address.state + ",   Pin.- " +  address.pincode
      all_address << add
    end
    return all_address
  end
end
