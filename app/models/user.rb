class User < ApplicationRecord
  has_secure_password
  has_many :addresses

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mobile, presence: true
end
