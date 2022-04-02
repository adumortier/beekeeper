# encoding: UTF-8

class BookingProductsController < ApplicationController

  def destroy
    booking_product = BookingProduct.find(params[:id])
    destroy_booking_product(booking_product)
    notify_destroy
  end

  private

  def notify_destroy
    flash['success'] = 'Votre modification a été prise en compte.'
    redirect_to reservation_path
  end

  def destroy_booking_product(booking_product)
    booking = booking_product.booking
    booking_product.destroy
    current_user.send_change_confirmation(booking)
    booking.destroy if booking.booking_products.empty?
  end

end 