class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :product_images


  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :product_images, presence: true
end
