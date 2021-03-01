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
    if @product.valid?
      flash[:success] = "Votre nouveau produit a été crée"
    else
      flash[:danger] = @product.errors.full_messages.to_sentence
    end
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
    params.require('product').permit(:description, :price, :year, :season, :status)
  end

end