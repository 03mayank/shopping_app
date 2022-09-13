class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :set_cart
  before_action :set_product



  
  def set_current_user
    if session[:user_id]
      Current.user = User.find(session[:user_id])
    end
  end

  def user_logged_in?
    if Current.user.nil?
      redirect_to sign_in_path, alert: "You must be signed in"
    end
  end

  def user_admin?
    if Current.user.email != "admin@sz.com"
      redirect_to products_path, alert: "User must be admin"
    end
  end
  
  def set_cart
    Current.cart ||= Current.user.get_or_create_cart if Current.user.present?
  end
  

  def set_product
    @products = Product.all
   end
end
