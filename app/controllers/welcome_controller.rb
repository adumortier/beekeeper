class WelcomeController < ApplicationController

  def index
    @posts = Post.order(created_at: :desc)
    @mobile_browser = browser_info
  end

end