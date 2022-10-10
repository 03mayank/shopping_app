class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception
  
  before_action :update_allowed_parameters, if: :devise_controller?
  before_action :set_current_user
  before_action :set_cart

  def set_current_user
    if user_signed_in?
      Current.user = current_user
    end
  end

  def user_logged_in?
    if Current.user.nil?
      redirect_to sign_in_path, alert: "You must be signed in"
    end
  end

  def user_admin?
    if Current.user.email != "admin@sz.com"
      redirect_to root_path, notice: "User must be admin"
    end
  end
  
  def set_cart
    Current.cart ||= Current.user.get_or_create_cart if Current.user.present?
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :first_name, :last_name, :mobile)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :email, :password, :current_password)}
  end
end
