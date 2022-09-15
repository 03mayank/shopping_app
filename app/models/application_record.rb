class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  # def initialize_order_quantity
  #   order.quantity = cart_items.quantity
  # end
end
