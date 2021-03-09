class WelcomeController < ApplicationController

  def index
    Rails.logger.info "Check out this info!"
    @posts = Post.most_recent_first
  end

end