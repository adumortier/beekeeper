class WelcomeController < ApplicationController

  def index
    @posts = Post.all
    @mobile_browser = browser_info.mobile?
  end

end