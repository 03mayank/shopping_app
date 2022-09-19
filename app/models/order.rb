class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  accepts_nested_attributes_for :order_items

  validates :address, presence: true
  validates :total_amount, numericality: { greater_than: 0 }

end
