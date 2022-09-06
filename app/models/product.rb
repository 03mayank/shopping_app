class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :product_image


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :product_image, presence: true
end
