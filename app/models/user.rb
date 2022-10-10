class User < ApplicationRecord
  after_create :sign_up_mail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # has_secure_password
  has_many :addresses
  has_one :cart
  has_many :orders

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :mobile, presence: true, :numericality => true, :length => { :minimum => 10, :maximum => 15 }

  def sign_up_mail
    SignupJob.perform_later(self)
  end
  
  def get_or_create_cart
    cart || create_cart
  end
end
