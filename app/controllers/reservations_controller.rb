# encoding: UTF-8

class ReservationsController < BaseController

  skip_before_action :require_current_user, only: [:index]

  def index
    @bookings = current_user.bookings.order(created_at: :desc) if current_user
  end

  def new
    @booking = current_user.bookings.new
    @products_spring = Product.spring.where(status: 'active').order(price: :asc)
    @products_summer = Product.summer.where(status: 'active').order(price: :asc)
  end

  def create
    products = Product.current
    
    @booking = current_user.bookings.create!(comment: booking_params[:comment])
    products.each do |product|
      quantity = booking_params[product.description + '_' + product.season]
      @booking.booking_products.create(product: product, quantity: quantity)
    end
    if (@booking.booking_products.pluck(:quantity).empty?) || (@booking.booking_products.pluck(:quantity).sum == 0)
      if @booking.has_comment?
        flash['danger'] = 'Réservez pour pouvoir envoyer votre message.'
      else
        flash['danger'] = 'Indiquez les quantités souhaitées.'
      end
      @booking.destroy
      redirect_to reservation_new_path
    else
      current_user.send_booking_confirmation(@booking)
      current_user.send_message_to_admin(@booking)
      flash['success'] = 'Votre réservation a été enregistrée.'
      redirect_to root_path
    end
  end

  def destroy
    booking_product = BookingProduct.find(params[:id])
    booking = booking_product.booking
    booking_product.destroy
    booking.destroy if booking.booking_products.empty?
    if browser_info.mobile?
      flash['success'] = 'Votre modification a été prise en compte.'
    else
      flash['success'] = 'Votre modification a été prise en compte. Nous vous envoyons un email de confirmation.'
    end
    current_user.send_change_confirmation(booking)
    redirect_to reservation_path
  end

  private

  def booking_params
    product_description = Product.all.pluck(:description,:season).map {|prod| prod.join('_')}
    params.require(:booking).permit(product_description, :comment)
  end

end
