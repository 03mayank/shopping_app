class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user

  def total_cart_value
    sum = 0
    self.cart_items.each do |cart_item|
      price = cart_item.product.price * cart_item.quantity
      sum += price
    end
    return sum
  end
end
