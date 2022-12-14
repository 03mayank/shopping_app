class ProductsController < ApplicationController
  before_action :user_logged_in?, only: :index
  before_action :user_admin?, only: %i[new edit update destroy]
  before_action :set_product, only: %i[edit update destroy]
  before_action :set_category, only: %i[create update]
  before_action :set_category_names, only: %i[new edit create]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = @category.products.new(product_params)
    if @product.save
      redirect_to products_path, notice: "Product Added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = @product.category
  end

  def update
    @product.category = @category
    if @product.update(product_params)
      redirect_to products_path, notice: "Product updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other, notice: 'Product deleted'
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, product_images: [])
  end

  def category_params
    params.require(:product).permit(:category_name)
  end

  def set_category
    @category = Category.find_by(category_name: category_params[:category_name])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_category_names
    @category_names = Category.all.pluck(:category_name)
  end
end
