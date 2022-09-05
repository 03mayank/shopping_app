class Category < ApplicationRecord
  has_many :products

  validates :category_name, presence: true
end
