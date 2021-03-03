require "image_processing/mini_magick"

class Admin::PostsController < Admin::BaseController

  def index 
    @posts = current_user.posts.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    if post_params[:images].nil?
      flash[:danger] = "Il manque une image pour ce post."
      redirect_to new_admin_post_path
    else
      processed = Post.resize_image(post_params[:images].first.tempfile)
      post_params[:images].first.tempfile = processed
      post = current_user.posts.create(post_params)
      post.images.attach(post_params[:images])
      redirect_to admin_posts_path
    end
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
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