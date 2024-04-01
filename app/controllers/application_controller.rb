# encoding: UTF-8

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_admin, :login, :bookings_spring, :bookings_summer, :browser_info, :mobile_user?, :desktop_user?, :mobile_visitor?, :current_class?, :browser_type, :products_spring, :products_summer

  def current_user
    user = session[:user]
    @current_user ||= User.find(user) if user
  end

  def session_store(id)
    session[:user] = id
  end

  def current_admin
    current_user&.admin?
  end

  def mobile_user?
    current_user && browser_info.mobile?
  end

  def desktop_user?
    current_user && !browser_info.mobile?
  end

  def mobile_visitor?
    !current_user && browser_info.mobile?
  end

  def bookings_spring
    @bookings_spring ||= Booking.joins(:products).where(products: {season:'printemps'}).where(products: {year:Time.new.year}).distinct
  end

  def bookings_summer
    @bookings_summer ||= Booking.joins(:products).where(products: {season:'été'}).where(products: {year:Time.new.year}).distinct
  end

  def products_spring
    @products_spring ||= Product.current_year.spring.active
  end

  def products_summer
    @products_summer ||= Product.current_year.summer.active
  end

  def browser_info
    Browser::Base.include(Browser::Aliases)
    Browser.new(request.env["HTTP_USER_AGENT"])
  end

  def browser_type
    Browser::Base.include(Browser::Aliases)
    @browser_type ||= Browser.new(request.env["HTTP_USER_AGENT"]).mobile? ? 'mobile' : 'desktop'
  end

  def current_class?(*test_paths)
    test_paths.any? { |test_path| request.path == test_path } ? 'active' : ''
  end

  private 

  def load_bookings
    current_year = Time.new.year
    bookings_users = Booking.joins(:user)
    direction = params[:direction]
    season = params[:season]
    sort = params[:sort]
    case sort
    when 'users.last_name'
      bookings_users.merge(User.order("last_name #{direction}")).joins(:products).where('products.season = ?', season).where('products.year = ?', current_year).uniq
    when 'users.email'
      bookings_users.merge(User.order("email  #{direction}")).joins(:products).where('products.season = ?', season).where('products.year = ?', current_year).uniq
    when 'created_at'
      Booking.joins(:products).where('products.season = ?', season).where('products.year = ?', current_year).order("#{sort} #{direction}").distinct
    end
  end

  def load_users
    User.where(role: 0).order("#{params[:sort]} #{params[:direction]}").decorate
  end

  def require_current_user
    render file: '/public/403' unless current_user
  end
end
