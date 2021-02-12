# encoding: UTF-8

class ReservationsController < BaseController

  after_action :set_cache_buster, only: :create 

  def index
    @bookings = current_user.bookings.order(created_at: :asc)
  end

  def new
    @booking = current_user.bookings.new
    @products_spring = Product.where(year: Time.new.year).where(season: 'printemps').where(status: 'active').order(price: :asc)
    @products_summer = Product.where(year: Time.new.year).where(season: 'été').where(status: 'active').order(price: :asc)
  end

  def create
    products = Product.where('year = ?', Time.new.year)
    
    @booking = current_user.bookings.create!(comment: booking_params[:comment])
    products.each do |product|
      quantity = booking_params[product.description + '_' + product.season]
      @booking.booking_products.create(product: product, quantity: quantity)
    end
    if (@booking.booking_products.pluck(:quantity).empty?) || (@booking.booking_products.pluck(:quantity).sum == 0)
      if @booking.has_comment?
        flash['danger'] = 'Réservez pour pouvoir envoyer votre message.'
        redirect_to reservation_new_path
      else
        flash['danger'] = 'Indiquez les quantités souhaitées.'
        redirect_to reservation_new_path
      end
    else
      current_user.send_booking_confirmation(@booking)
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
