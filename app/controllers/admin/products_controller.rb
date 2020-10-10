class Admin::ProductsController < BaseController

  before_action :require_admin
  
  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
  end
  
  def edit
    @product = Product.find(params[:id])
  end
  
  def create
    Product.create(product_params)
    redirect_to '/admin/products'
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to '/admin/products'
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to '/admin/products'
  end
  
  private

  def require_admin
    render file: "/public/404" unless current_admin?
  end

  def product_params
    params.require('product').permit(:description, :price, :year, :season)
  end

end