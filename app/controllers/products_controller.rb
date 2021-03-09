# this class is responsible for...

# encoding: UTF-8
class ProductsController < ApplicationController

  def index
    @products_spring = Product.current_year.spring.active
    @products_summer = Product.current_year.summer.active
  end

end