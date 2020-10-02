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

end