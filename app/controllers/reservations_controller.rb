# encoding: UTF-8

class ReservationsController < ApplicationController

  def index
    @bookings = current_user.bookings.all
  end

  def new
    @booking = current_user.bookings.new
    @products = Product.where(year: Time.new.year)
  end

  def create
    products = Product.where('year = ?', Time.new.year)
    @booking = current_user.bookings.create
    products.each do |product|
      quantity = booking_params[product.description + '_' + product.season]
      @booking.booking_products.create(product: product, quantity: quantity)
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
