# this class is responsible for...

# encoding: UTF-8
class ProductsController < ApplicationController

  def index
    @products_spring = Product.spring.where(status: 'active')
    @products_summer = Product.summer.where(status: 'active')
  end

end