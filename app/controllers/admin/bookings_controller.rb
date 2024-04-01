# encoding: UTF-8

class Admin::BookingsController < Admin::BaseController

  def index
    @products_spring = Product.spring.current_year
    @products_summer = Product.summer.current_year
    current_year = Time.new.year
    if params[:sort].present?
      season = params[:season]
      @bookings_spring = (season == 'printemps'? load_bookings : bookings_spring)
      @bookings_summer = (season == 'été'? load_bookings : bookings_summer)
    else
      booking_and_products = Booking.joins(:products)
      @bookings_spring = booking_and_products.where(products: {season:'printemps'}).where(products: {year: current_year}).distinct
      @bookings_summer = booking_and_products.where(products: {season:'été'}).where(products: {year: current_year}).distinct
    end
  end

  def new
    @user = User.find(params[:id])
    @booking = @user.bookings.new
    @products_spring = Product.spring.current_year
    @products_summer = Product.summer.current_year
  end

  def create
    user = User.find(params[:id])
    @booking = user.bookings.create
    @booking.add_booking_products(Product.current_year, booking_params)
    user.send_admin_booking_confirmation(@booking)
    flash['success'] = "Un email a été envoyé à #{user.first_name + ' ' + user.last_name} pour confirmer la réservation."
    redirect_to admin_user_path
  end

  def edit 
    @booking = Booking.find(params[:booking_id])
    @products_spring = Product.spring
    @products_summer = Product.summer
  end

  def update
    booking_product = BookingProduct.find(params[:booking_id])
    booking = booking_product.booking
    
    season = booking_product.product.season
    booking_products = BookingProduct.joins(:product).where(products:{season: season}).where(booking_id: booking.id)
    user = User.find(params[:user_id])
    user.send_admin_pickup_notification(booking, booking_products)
    booking_products.update(status: :notified)
    
    flash['success'] = "Un email a été envoyé à #{user.first_name + ' ' + user.last_name} pour confirmer la disponibilité des pots."
    redirect_to admin_bookings_path
  end

  private

  def booking_params
    product_description = Product.all.pluck(:description,:season).map {|prod| prod.join('_')}
    params.require(:booking).permit(product_description)
  end

end