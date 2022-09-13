class WelcomeController < ApplicationController
  before_action :set_product
  def index
  end
  
  private
   
  def set_product
   @products = Product.all
  end
end

