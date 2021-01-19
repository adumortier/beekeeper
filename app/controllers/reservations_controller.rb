# encoding: UTF-8

class ReservationsController < ApplicationController

  def index
    @bookings = current_user.bookings.order(created_at: :desc)
  end

  def new
    @booking = current_user.bookings.new
    @products_spring = Product.where(year: Time.new.year).where(season: 'printemps').where(status: 'active')
    @products_summer = Product.where(year: Time.new.year).where(season: 'été').where(status: 'active')
  end

  def create
    products = Product.where('year = ?', Time.new.year)
    @booking = current_user.bookings.create
    products.each do |product|
      quantity = booking_params[product.description + '_' + product.season]
      @booking.booking_products.create(product: product, quantity: quantity)
    end
    unless (@booking.booking_products.pluck(:quantity).empty?) || (@booking.booking_products.pluck(:quantity).sum == 0)
      current_user.send_booking_confirmation(@booking) 
    end
    redirect_to reservation_path
  end

  def destroy
    booking_product = BookingProduct.find(params[:id])
    booking_product.destroy
    flash['success'] = 'Votre réservation a été annulée'
    redirect_to reservation_path
  end

  private

  def booking_params
    product_description = Product.all.pluck(:description,:season).map {|prod| prod.join('_')}
    params.require(:booking).permit(product_description)
  end

end
