class Address < ApplicationRecord
  belongs_to :user

  validates :area, presence: true
  validates :city, presence: true
  validates :pincode, presence: true, numericality: true, :length => { :is => 6 }
  validates :state, presence: true
end
