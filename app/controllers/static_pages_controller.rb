class StaticPagesController < ApplicationController

  def not_found
    render file: '/public/404'
  end

end