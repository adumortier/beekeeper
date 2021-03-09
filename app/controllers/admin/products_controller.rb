# encoding: UTF-8
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
    @product = Product.create(product_params)
    @product.valid? ? notify_create : notify_error(@product)
  end
  
  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to admin_products_path
  end
  
  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to admin_products_path
  end
  
  private

  def product_params
    params.require('product').permit(:description, :price, :year, :season, :status)
  end

  def notify_create
    flash[:success] = 'Votre nouveau produit a été crée.'
    redirect_to admin_products_path
  end

  def notify_error(product)
    flash[:danger] = product.errors.full_messages.to_sentence
    redirect_to admin_products_path
  end

end