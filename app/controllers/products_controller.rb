# encoding: UTF-8
class ProductsController < ApplicationController

  def index
    @products_spring = Product.where(year: Date.current.year).where(season: 'printemps').where(status: 'active')
    @products_summer = Product.where(year: Date.current.year).where(season: 'été').where(status: 'active')
  end

end