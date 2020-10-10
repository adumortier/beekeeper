class Admin::PostsController < Admin::BaseController

  def index 
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    post = current_user.posts.create(post_params)
    post.images.attach(post_params[:images])
    redirect_to admin_posts_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require('post').permit(:title, :content, images: [] )
  end

end