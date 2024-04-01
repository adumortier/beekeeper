# encoding: UTF-8

class ReservationsController < BaseController

  skip_before_action :require_current_user, only: [:index]

  def index
    @bookings = current_user.bookings.order(created_at: :desc).includes(:booking_products).decorate if current_user
  end

  def new
    @booking = current_user.bookings.new
  end

  def create
    products = Product.current_year
    @booking = current_user.bookings.create!(comment: booking_params[:comment])
    add_booking_products(@booking, products)
    empty_booking?(@booking) ? notify_error(@booking) : notify_booking(@booking)
  end

  private

  def booking_params
    product_description = Product.all.pluck(:description, :season).map {|prod| prod.join('_')}
    params.require(:booking).permit(product_description, :comment)
  end

  def notify_booking(booking)
    current_user.send_booking_confirmation(booking)
    current_user.send_message_to_admin(booking)
    flash['success'] = 'Votre réservation a été enregistrée.'
    redirect_to root_path
  end

  def notify_error(booking)
    error = booking.has_comment? ? 'Réservez pour pouvoir envoyer votre message.' : 'Indiquez les quantités souhaitées.'
    flash['danger'] = error
    booking.destroy
    redirect_to reservation_new_path
  end

  def add_booking_products(booking, products)
    products.each do |product|
      quantity = booking_params[product.description + '_' + product.season]
      booking.booking_products.create(product: product, quantity: quantity)
    end
  end
  
  def empty_booking?(booking)
    booking.booking_products.pluck(:quantity).empty? || booking.booking_products.pluck(:quantity).sum.zero?
  end
end
