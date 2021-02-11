class BaseController < ApplicationController

  before_action :require_current_user

  private 
  
  def require_current_user
    render file: "/public/403" unless current_user
  end

end