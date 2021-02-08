# encoding: UTF-8

class Admin::BookingsController < Admin::BaseController

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
    @products_spring = Product.where(year: Time.new.year).where(season: 'printemps')
    @products_summer = Product.where(year: Time.new.year).where(season: 'été')
  end

  def create
    user = User.find(params[:id])
    products = Product.where('year = ?', Time.new.year)
    @booking = user.bookings.create
    products.each do |product|
      quantity = (booking_params[product.description + '_' + product.season].empty? ? 0 : booking_params[product.description + '_' + product.season])
      @booking.booking_products.create(product: product, quantity: quantity)
    end
    user.send_admin_booking_confirmation(@booking)
    flash['success'] = "Un email a été envoyé à #{user.first_name + ' ' + user.last_name} pour confirmer la réservation."
    redirect_to admin_user_path
  end

  def edit 
    @booking = Booking.find(params[:booking_id])
    @products_spring = Product.where(year: Time.new.year).where(season: 'printemps')
    @products_summer = Product.where(year: Time.new.year).where(season: 'été')
  end

  def update
    user = User.find(params[:user_id])
    booking = Booking.find(params[:booking_id])
    products = Product.where('year = ?', Time.new.year)
    products.each do |product|
      quantity = (booking_params[product.description + '_' + product.season].empty? ? 0 : booking_params[product.description + '_' + product.season])
      booking.booking_products.where(product_id: product.id).update(quantity: quantity)
    end
    flash['success'] = "Un email a été envoyé à #{user.first_name + ' ' + user.last_name} pour confirmer la réservation."
    redirect_to admin_bookings_path
  end

  private

  def booking_params
    product_description = Product.all.pluck(:description,:season).map {|prod| prod.join('_')}
    params.require(:booking).permit(product_description)
  end


end