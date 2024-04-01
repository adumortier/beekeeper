class WelcomeController < ApplicationController

  def index
    @posts = Post.most_recent_first.paginate(:page => params[:page], :per_page => 3)
  end

end