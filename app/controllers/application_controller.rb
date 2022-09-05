class ApplicationController < ActionController::Base
  before_action :set_current_user
  
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
end
