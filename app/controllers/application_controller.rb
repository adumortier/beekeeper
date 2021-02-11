# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin, :login, :bookings_spring, :bookings_summer, :browser_info

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

  def browser_info
    Browser::Base.include(Browser::Aliases)
    Browser.new(request.env["HTTP_USER_AGENT"])
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

  def load_users
    User.where(role: 0).order("#{params[:sort]} #{params[:direction]}")
  end

  def require_current_user
      render file: "/public/403" unless current_user
  end

    protected

    def set_cache_buster
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "#{1.year.ago}"
    end
    
end
