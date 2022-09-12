class User < ApplicationRecord
  has_secure_password
  has_many :addresses
  has_one :cart

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mobile, presence: true, :numericality => true, :length => { :minimum => 10, :maximum => 15 }

    def get_or_create_cart
      cart || create_cart
    end
end
