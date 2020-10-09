# encoding: UTF-8

class Admin::BookingsController < ApplicationController

  def index
    @spring_products = Product.where({season: 'printemps', year: Time.new.year})
    @summer_products = Product.where({season: 'été', year: Time.new.year})
    if params[:sort].present?
      @bookings_spring = (params[:season] == 'printemps'? load_bookings : bookings_spring)#Booking.joins(:products).where(products: {season:'printemps'}).where(products: {year:Time.new.year}).distinct ) 
      @bookings_summer = (params[:season] == 'été'? load_bookings : bookings_summer) #Booking.joins(:products).where(products: {season:'été'}).where(products: {year:Time.new.year}).distinct )
    else
      @bookings_spring = Booking.joins(:products).where(products: {season:'printemps'}).where(products: {year:Time.new.year}).distinct
      @bookings_summer = Booking.joins(:products).where(products: {season:'été'}).where(products: {year:Time.new.year}).distinct
    end
  end

  def new
    @user = User.find(params[:id])
    @booking = @user.bookings.new
    @products = Product.where(year: Time.new.year)
  end

  def create
    user = User.find(params[:id])
    products = Product.where('year = ?', Time.new.year)
    @booking = user.bookings.create
    products.each do |product|
      quantity = (booking_params[product.description + '_' + product.season].empty? ? 0 : booking_params[product.description + '_' + product.season])
      @booking.booking_products.create(product: product, quantity: quantity)
    end
    redirect_to "/admin/users/#{user.id}"
  end

  private

  def booking_params
    product_description = Product.all.pluck(:description,:season).map {|prod| prod.join('_')}
    params.require(:booking).permit(product_description)
  end


end