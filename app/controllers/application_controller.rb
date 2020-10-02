# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin, :login, :bookings_spring, :bookings_summer

  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end

  def login(user)
    session[:user] = user.id
  end

  def current_admin
    current_user && current_user.admin?
  end

  def bookings_spring
    @bookings_spring ||= Booking.joins(:products).where(products: {season:'printemps'}).where(products: {year:Time.new.year}).distinct
  end

  def bookings_summer
    @bookings_summer ||= Booking.joins(:products).where(products: {season:'été'}).where(products: {year:Time.new.year}).distinct
  end

  private 

  def load_bookings
    case params[:sort]
    when 'users.last_name'
      Booking.joins(:user).merge(User.order("last_name #{params[:direction]}")).joins(:products).where('products.season = ?', params[:season]).where('products.year = ?' ,Time.new.year).uniq
    when 'users.email'
      Booking.joins(:user).merge(User.order("email  #{params[:direction]}")).joins(:products).where('products.season = ?', params[:season]).where('products.year = ?' ,Time.new.year).uniq
    when 'created_at'
      Booking.joins(:products).where('products.season = ?', params[:season]).where('products.year = ?' ,Time.new.year).order("#{params[:sort]} #{params[:direction]}").distinct
    end
  end

end
