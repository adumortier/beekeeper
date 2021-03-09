# encoding: UTF-8
require 'image_processing/mini_magick'

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
    post_params[:images].nil? ? notify_error : add_images_to_post(post_params[:images])
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

  def add_images_to_post(images)
    processed = Post.resize_image(images.first.tempfile)
    images.first.tempfile = processed
    post = current_user.posts.create(post_params)
    post.images.attach(images)
    notify_create
  end

  def notify_create
    flash[:success] = 'Le post a été crée.'
    redirect_to admin_posts_path
  end

  def notify_error
    flash[:danger] = 'Il manque une image pour ce post.'
    redirect_to new_admin_post_path
  end

end