class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
