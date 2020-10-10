class Admin::ProductsController < Admin::BaseController
  
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
    redirect_to admin_products_path
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to admin_products_path
  end
  
  private

  def product_params
    params.require('product').permit(:description, :price, :year, :season)
  end

end